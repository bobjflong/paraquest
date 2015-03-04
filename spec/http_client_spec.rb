require 'rspec'
require 'http_client'
require File.expand_path("../../lib/paraquest/http_client", __FILE__)

module Paraquest
  describe do
    it do
      expect(Paraquest::Client('http://google.ie')).to be_a(::HTTP::Client)
    end
  end
end
