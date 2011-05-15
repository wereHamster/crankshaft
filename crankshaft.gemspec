require 'bundler'
require File.expand_path('../lib/crankshaft/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name         = 'crankshaft'
  spec.homepage     = 'http://github.com/wereHamster/crankshaft'
  spec.summary      = 'Ruby bindings for the Transmission BitTorrent client'
  spec.require_path = 'lib'
  spec.authors      = ['Tomas Carnecky']
  spec.email        = ['tomas.carnecky@gmail.com']
  spec.version      = Crankshaft::Version
  spec.platform     = Gem::Platform::RUBY
  spec.files        = Dir.glob("lib/**/*") + %w[LICENSE README.md]

  spec.add_dependency 'json', '~> 1.5'

  spec.add_development_dependency 'rake', '~> 0.8'
  spec.add_development_dependency 'shoulda', '~> 2.11'
end
