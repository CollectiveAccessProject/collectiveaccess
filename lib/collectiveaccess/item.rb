module CollectiveAccess
  class Item
    def self.get(*opts)
      opts[:method] = :get

      CollectiveAccess::Base.request(opts)
    end
  end
end
