require File.expand_path("../lib/paraquest/version", __FILE__)

Gem::Specification.new do |gem|
  gem.name    = 'paraquest'
  gem.version = Paraquest::VERSION

  gem.summary = "Easy request trees"
  gem.description = "Produce dependency trees - execute as network requests"

  gem.authors  = ['Bob Long']
  gem.email    = 'robertjflong@gmail.com'
  gem.homepage = 'http://github.com/bobjflong/paraquest'

  gem.require_path = 'lib'

  gem.add_dependency('rake')
  gem.add_dependency('jruby-httpclient')
  gem.add_dependency('ribimaybe')
  gem.add_development_dependency('rspec', [">= 2.0.0"])
  gem.add_development_dependency('fuubar')

  # ensure the gem is built out of versioned files
  gem.files = Dir['Rakefile', 'lib/**/*', 'README*', 'LICENSE*'] & `git ls-files -z`.split("\0")
end
