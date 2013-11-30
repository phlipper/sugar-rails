# -*- encoding: utf-8 -*-
require File.expand_path('../lib/sugar/rails/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Phil Cohen"]
  gem.email         = ["github@phlippers.net"]
  gem.description   = %q{Sugar, tastefully bundled for the Rails 3.0 and up. Sweet!}
  gem.summary       = %q{Sugar, tastefully bundled for the Rails 3.0 and up. Sweet!}
  gem.homepage      = "http://phlippers.net/sugar-rails"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "sugar-rails"
  gem.require_paths = ["lib"]
  gem.version       = Sugar::Rails::VERSION

  gem.add_dependency "railties", ">= 3.0.0"
  gem.add_development_dependency "bundler", ">= 1.1.0"

  gem.add_development_dependency "rails", "~> 4.0.1"
  gem.add_development_dependency "minitest-rails-capybara", "~> 0.10.0"
  gem.add_development_dependency "sqlite3", "~> 1.3.8"
end
