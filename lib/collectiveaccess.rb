require 'json'
require 'httparty'

#$:.unshift(File.dirname(__FILE__))
#require 'collectiveaccess/item'

class CollectiveAccess

  # 'class-level' instance variables are weird. they're
  # considered better style than class variables though
  @user_name = ENV['CA_SERVICE_API_USER']
  @user_key = ENV['CA_SERVICE_API_KEY']

  DEFAULT_REQUEST_OPTS = {
      hostname: 'localhost',
      protocol:  'http',
      url_root: '/',
      script_name: 'service.php',
      table_name: 'ca_objects',
      endpoint: 'item',
      method: 'GET',
      request_body: {},
      get_params: {},
      url_string: '/id/1'
  }

  def self.set_credentials(user_name, key)
    @user_name = user_name
    @user_key = key
    true
  end

  def self.request(request_opts = {})
    opts = DEFAULT_REQUEST_OPTS.merge(request_opts)

    url = opts[:protocol]+'://'+opts[:hostname]+opts[:url_root]+opts[:script_name]+'/'+opts[:endpoint]+'/'+opts[:table_name]+'/'+opts[:url_string]

    foo = HTTParty.get url, basic_auth: { username: @user_name, password: @user_key }

    puts "#{foo}"
  end
end
