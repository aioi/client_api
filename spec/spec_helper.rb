require 'rubygems'
require 'client_api'
require 'webmock/rspec'
require 'spec'

include WebMock::API

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end

def fixture(file)
  File.new(fixture_path + '/' + file)
end

