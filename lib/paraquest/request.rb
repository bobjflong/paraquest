require 'veto'
require 'http_client'
require 'benchmark'
require 'uri'

module Paraquest
  POST = :post
  GET  = :get
  PUT  = :put

  METHODS = [POST, GET, PUT]

  class RequestValidator
    include Veto.validator
    validates :endpoint, presence: true
    validates :params, presence: true
    validates :method, inclusion: METHODS

    validate  :type_of_then

    def type_of_then(request)
      unless request.then.is_a?(Array)
        errors.add(:requests, 'must be a list')
      end
    end
  end

  class Request

    attr_reader :client, :endpoint, :params, :method, :then

    def initialize(opts = {})
      opts.each do |k,v|
        instance_variable_set("@#{k}", v)
      end
      raise ArgumentError.new(validation_error_string) unless valid?
    end

    def resolve
      client.send(method, endpoint, params)
    end

    private

    def parsed_uri
      @parsed_uri ||= URI(endpoint)
    end

    def client
      @client ||= Paraquest::Client()
    end

    def valid?
      @valid ||= validator.valid?(self)
    end

    def validation_error_string
      valid?
      validator.errors.full_messages.join(', ')
    end

    def validator
      @validator ||= RequestValidator.new
    end
  end
end
