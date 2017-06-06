$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "renderable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |gem|
  gem.authors     = "Jon Pearse"
  gem.email       = "jon@jonpearse.net"
  gem.summary     = "Textile->HTML pre-rendering for ActiveRecord via RedCloth"
  gem.description = "renderable provides a simple hook for ActiveRecord that converts Textile to HTML when the object is saved"
  gem.homepage    = "https://github.com/jonpearse/renderable"
  gem.license     = "MIT"

  gem.files       = `git ls-files`.split($\)
  gem.name        = "renderable"
  gem.version     = Renderable::VERSION

  gem.add_dependency('RedCloth', '~> 4.3.0')
end
