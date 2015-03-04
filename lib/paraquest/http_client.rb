require 'http_client'

module Paraquest
  def self.Client(*args)
    if args.length == 1 && args.fetch(0).is_a?(String)
      ::HTTP::Client.new(default_host: args.fetch(0))
    end
  end
end
