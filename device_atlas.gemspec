# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 1.9.0'
  s.required_rubygems_version = ">= 1.3.6"

  s.name        = "device_atlas"
  s.summary     = "DeviceAtlas Parser & Client"
  s.description = "Faster Ruby implmentation"
  s.version     = "0.2.0"

  s.authors     = ["Dimitrij Denissenko"]
  s.email       = "dimitrij@blacksquaremedia.com"
  s.homepage    = "https://github.com/bsm/device_atlas"

  s.require_path = 'lib'
  s.files        = Dir['lib/**/*']

  s.add_dependency "multi_json"
  s.add_development_dependency "rake"
  s.add_development_dependency "bundler"
  s.add_development_dependency "rspec"
  s.add_development_dependency "oj"
end
