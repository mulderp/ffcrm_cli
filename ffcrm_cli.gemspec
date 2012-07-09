$:.unshift File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = 'ffcrm_cli'
  s.version     = '0.0.0'
  s.date        = '2012-07-06'
  s.summary     = "ffcrm_cli import and export"
  s.description = "A simple hello world gem"
  s.authors     = ["Patrick Mulder"]
  s.email       = 'mulder.patrick@gmail.com'
  s.executables = %w( ffcrm )
  s.files       = Dir["**/*"].select { |d| d =~ %r{^(README|VERSION|bin/|data/|ext/|lib/|spec/|test/)} }
  s.homepage    = 'http://github.com/mulderp'

  s.require_paths = ["lib", "tasks"]
end
