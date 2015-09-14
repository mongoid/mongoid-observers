# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongoid/observers/version'

Gem::Specification.new do |spec|
  spec.name          = "mongoid-observers"
  spec.version       = Mongoid::Observers::VERSION
  spec.authors       = ["Chamnap Chhorn"]
  spec.email         = ["chamnapchhorn@gmail.com"]
  spec.summary       = %q{Mongoid observer (removed in Mongoid 4.0)}
  spec.description   = %q{Mongoid::Observer removed from Mongoid 4.0}
  spec.homepage      = "https://github.com/chamnap/mongoid-observers"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails-observers", "~> 0.1.2"
  spec.add_dependency "mongoid", ">= 5.0.0"
end
