#lib = "client_api"
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'client_api/version'

Gem::Specification.new do |spec|
  spec.name = 'client_api'
  spec.version = ClientApi::VERSION
  spec.authors     = ["Sharon Deng"]
  spec.email = ['..']
  spec.homepage = 'https://github.com/....'
  spec.description = %q{Aioi application http/client library }
  spec.summary = spec.description

  spec.files = [
      "lib/client_api.rb"
  ]
  spec.files += Dir.glob("lib/**/*.rb")
  spec.files += Dir.glob("test/**/*.{rb,txt}")

  spec.test_files = Dir.glob("test/**/*.rb")
  #spec.files = %w(.document CHANGELOG.md CONTRIBUTING.md Gemfile LICENSE.md README.md Rakefile)
  #spec.files << "#{lib}.gemspec"
  #spec.files += Dir.glob("lib/**/*.rb")
  #spec.files += Dir.glob("test/**/*.{rb,txt}")
  #spec.files += Dir.glob("script/*")

  spec.require_paths = ["lib"]

  spec.add_dependency 'faraday_middleware', '~> 0.9.0'
  spec.add_dependency 'net-http-persistent'
  spec.add_dependency 'activesupport' ,'~> 3.2'
  spec.add_dependency "json"
  spec.add_dependency "multi_xml"
  #spec.add_runtime_dependency 'faraday_middleware', '~> 0.9.0'
  #spec.add_runtime_dependency 'net-http-persistent'

  spec.add_development_dependency 'bundler', '~> 1.0'
  spec.add_development_dependency 'rspec', '~> 1.3'
  spec.add_development_dependency 'webmock', '~> 1.6'

  # for some reason, the following gems that faraday_middleware gem depends on are not loaded in rspec test
  # have to specify the dependency here
  #spec.add_development_dependency "activesupport"
  #spec.add_development_dependency "json"
  #spec.add_development_dependency "multi_xml"

end
