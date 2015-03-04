require 'rspec'
require 'http_client'
require File.expand_path("../../lib/paraquest/client", __FILE__)
require File.expand_path("../../lib/paraquest/request", __FILE__)

module Paraquest
  describe Request do
    let(:endpoint) { 'http://example.com' }
    let(:params) { { foo: :bar } }
    let(:then_val) { [] }
    let(:valid_request) do
      Request.new(
        name: :request1,
        endpoint: endpoint,
        params: params,
        method: :post,
        then: then_val
      )
    end

    it do
      expect(valid_request).to be_a(Request)
    end

    it 'validates' do
      expect { Request.new }.to raise_error(ArgumentError)
    end

    context 'validates the \'then\' param' do
      let(:then_val) { :foo }

      it do
        expect { valid_request }.to raise_error(ArgumentError, 'requests must be a list')
      end
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
