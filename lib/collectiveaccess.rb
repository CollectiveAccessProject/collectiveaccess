require 'json'
require 'httparty'
require 'uri'
require 'pstore'
require 'tmpdir'

#$:.unshift(File.dirname(__FILE__))
#require 'collectiveaccess/item'

class CollectiveAccess

  include HTTParty

  format :json
  @auth = basic_auth ENV['CA_SERVICE_API_USER'], ENV['CA_SERVICE_API_KEY']

  DEFAULT_REQUEST_OPTS = {
    protocol: 'http',
    hostname: 'localhost',
    url_root: '/',
    script_name: 'service.php',
    table_name: 'ca_objects',
    endpoint: 'item',
    request_body: {},
    get_params: {},
    url_string: ''
  }


  # Overrides the default user credentials that read from
  # ENV['CA_SERVICE_API_USER'] and ENV['CA_SERVICE_API_KEY']
  def self.set_credentials(user_name, key)
    @auth = basic_auth user_name, key
  end

  # HTTP GET request
  def self.get(request_opts = {})
    custom_request :get, request_opts
  end

  # HTTP POST request
  def self.post(request_opts = {})
    custom_request :post, request_opts
  end

  # HTTP OPTIONS request
  def self.options(request_opts = {})
    custom_request :options, request_opts
  end

  # HTTP PUT request
  def self.put(request_opts = {})
    custom_request :put, request_opts
  end

  # HTTP DELETE request
  def self.delete(request_opts = {})
    custom_request :delete, request_opts
  end

  # Core request method. Tries to send the request with the given parameters. If it encounters a 401
  # it'll try to re-authenticate with the Web Service API and retries the same request. Returns a
  # parsed Hash containing the JSON response from the API or false if something went wrong.
  def self.custom_request(method, request_opts)
    opts = parse_options request_opts
    uri = build_uri opts

    resp = HTTParty.public_send method, uri, body: opts[:request_body].to_json

    # if 401 (access denied), try to re-authenticate
    if resp.code == 401
      delete_stored_auth_token # nuke old token
      authenticate opts
      # have to re-build the URI to include the new auth token
      new_uri = build_uri opts
      # try again
      resp = HTTParty.public_send method, new_uri, body: opts[:request_body].to_json
    end
    resp.parsed_response
  end

  def self.build_uri(opts)
    # URI available params: scheme, userinfo, host, port, registry, path, opaque, query and fragment
    url = URI::HTTP.build({ :scheme => opts[:protocol],
                            :host => opts[:hostname],
                            :path => opts[:url_root]+opts[:script_name]+'/'+opts[:endpoint]+'/'+opts[:table_name]+'/'+opts[:url_string],
                            :query => URI.encode_www_form(opts[:get_params].merge(authToken: stored_auth_token)) })
    url.path.gsub! %r{/+}, '/'
    url
  end

  def self.pstore
    PStore.new(Dir.tmpdir + File::PATH_SEPARATOR + 'collectiveaccess_gem_token.pstore')
  end

  # authenticate with CA Web Service API and store auth token in a temporary file
  def self.authenticate(request_opts = {})
    opts = parse_options request_opts
    auth_url = URI::HTTP.build({ :scheme => opts[:protocol],
                                 :host => opts[:hostname],
                                 :path => opts[:url_root] + '/service.php/auth/login',
                                 :query => URI.encode_www_form(opts[:get_params]) })
    auth_url.path.gsub! %r{/+}, '/'

    resp = HTTParty.get auth_url, basic_auth: @auth
    token = resp.parsed_response['authToken']

    if token
      store = pstore
      store.transaction do
        store[:token] = token
      end
    elsif
    false
    end
  end

  def self.stored_auth_token
    store = pstore
    store.transaction do
      token = store[:token]
      if token
        raise 'Token should be a string' unless token.is_a? String
        raise 'Token should be sha hash' unless (token.length == 64 && token =~ /\A[a-f0-9]+\Z/)
        token
      else
        false
      end
    end
  end

  def self.delete_stored_auth_token
    store = pstore
    store.transaction { store.delete :token }
  end

  def self.parse_options(opts = {})
    parsed_options = DEFAULT_REQUEST_OPTS.merge opts

    # do some basic parameter validations
    raise 'protocol has to be http or https' unless (parsed_options[:protocol] == 'http' || parsed_options[:protocol] == 'https')
    raise 'hostname should be a String' unless parsed_options[:hostname].is_a?(String)
    raise 'url_root should be a String' unless parsed_options[:url_root].is_a?(String)
    raise 'script_name should be a String' unless parsed_options[:script_name].is_a?(String)
    raise 'table_name should be a String' unless parsed_options[:table_name].is_a?(String)
    raise 'endpoint should be a String' unless parsed_options[:endpoint].is_a?(String)
    raise 'url_string should be a String' unless parsed_options[:url_string].is_a?(String)

    raise 'request_body should be a Hash' unless parsed_options[:request_body].is_a?(Hash)
    raise 'get_params should be a Hash' unless parsed_options[:get_params].is_a?(Hash)

    parsed_options
  end

  # make helpers private
  private_class_method :stored_auth_token, :pstore, :delete_stored_auth_token, :parse_options, :authenticate, :build_uri, :custom_request
end
