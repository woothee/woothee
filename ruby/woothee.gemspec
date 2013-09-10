# encoding: utf-8
# $:.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = "woothee"
  gem.description = "Cross-language UserAgent classifier library, ruby implementation"
  gem.homepage    = "https://github.com/tagomoris/woothee"
  gem.summary     = gem.description
  gem.version     = "0.3.4"
  gem.authors     = ["TAGOMORI Satoshi"]
  gem.email       = "tagomoris@gmail.com"
  gem.has_rdoc    = false
  #gem.platform    = Gem::Platform::RUBY
  gem.files       = `git ls-files`.split("\n")
  gem.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.add_development_dependency "rspec", ">= 2.8.0"
end
