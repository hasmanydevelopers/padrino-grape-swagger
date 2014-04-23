# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'padrino/grape/version'

Gem::Specification.new do |spec|
  spec.name          = "padrino-grape-swagger"
  spec.version       = Padrino::Grape::VERSION
  spec.authors       = ["Diorman Colmenares"]
  spec.email         = ["dextrin.diorman@gmail.com"]
  spec.summary       = "Use Grape with Padrino"
  spec.description   = "This gem allows Grape APIs to be mountable by Padrino"
  spec.homepage      = "https://github.com/hasmanydevelopers/padrino-grape-swagger"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "grape", "~> 0.7.0"
  spec.add_dependency "grape-swagger", "~> 0.7.2"
end
