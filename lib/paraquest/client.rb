require 'http_client'

module Paraquest
  def self.Client(*args)
    if first_argument_is_a?(args, String)
      ::HTTP::Client.new(default_host: args.fetch(0))
    elsif first_argument_is_a?(args, Hash)
      ::HTTP::Client.new(args.fetch(0))
    elsif args.length == 0
      ::HTTP::Client.new
    else
      raise ArgumentError.new('Arguments to Client must be a String or Hash')
    end
  end

  def self.first_argument_is_a?(o, klass)
    o.length == 1 && o.first.is_a?(klass)
  end
  private_class_method :first_argument_is_a?
end
