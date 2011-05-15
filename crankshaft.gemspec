require 'bundler'
require File.expand_path('../lib/crankshaft/version', __FILE__)

Gem::Specification.new do |s|
  s.name         = 'crankshaft'
  s.homepage     = 'http://github.com/wereHamster/crankshaft'
  s.summary      = 'Ruby bindings for the Transmission BitTorrent client'
  s.require_path = 'lib'
  s.authors      = ['Tomas Carnecky']
  s.email        = ['tomas.carnecky@gmail.com']
  s.version      = Crankshaft::Version
  s.platform     = Gem::Platform::RUBY
  s.files        = Dir.glob("lib/**/*") + %w[LICENSE README.md]

  s.add_dependency 'json'
  s.add_development_dependency 'shoulda'
end
