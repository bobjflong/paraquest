require 'http_client'

module Paraquest
  def self.Client(*args)
    if args.length == 1 && args.fetch(0).is_a?(String)
      ::HTTP::Client.new(default_host: args.fetch(0))
    elsif args.length == 1 && args.fetch(0).is_a?(Hash)
      ::HTTP::Client.new(args.fetch(0))
    else
      raise ArgumentError.new('Arguments to Client must be a String or Hash')
    end
  end
end
