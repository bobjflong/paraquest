require 'rspec'
require 'http_client'
require File.expand_path("../../lib/paraquest/client", __FILE__)
require File.expand_path("../../lib/paraquest/request", __FILE__)

module Paraquest
  describe Request do
    let(:endpoint) { 'http://example.com' }
    let(:params) { { foo: :bar } }
    let(:then) { [] }
    let(:valid_request) do
      Request.new(
        endpoint: endpoint,
        params: params,
        method: :post,
        then: []
      )
    end

    it do
      expect(valid_request).to be_a(Request)
    end

    it 'validates' do
      expect { Request.new }.to raise_error(ArgumentError)
    end

    it 'validates the \'then\' param' do
      expect do
        Request.new(
          endpoint: endpoint,
          params: params,
          method: :post,
          then: :foo
        )
      end.to raise_error(ArgumentError, 'requests must be a list')
    end

    it 'can create a client' do
      expect(valid_request.send(:client)).to be_a(HTTP::Client)
    end

    it 'can resolve requests' do
      expect_any_instance_of(HTTP::Client).to receive(:post).with(
        endpoint,
        params
      )
      valid_request.resolve
    end
  end
end
