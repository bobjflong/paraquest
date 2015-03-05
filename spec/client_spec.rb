require 'rspec'
require 'http_client'
require File.expand_path("../../lib/paraquest/client", __FILE__)

module Paraquest
  describe 'Client' do
    let(:host) { 'http://example.com' }

    it do
      expect(Paraquest::Client(host)).to be_a(::HTTP::Client)
    end

    it do
      expect(Paraquest::Client(default_host: host)).to be_a(HTTP::Client)
    end

    it 'validates' do
      expect { Paraquest::Client(Object.new) }.to raise_error(ArgumentError)
    end
  end
end
