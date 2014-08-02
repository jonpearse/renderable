$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "renderable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "renderable"
  s.version     = Renderable::VERSION
  s.authors     = ["Jon Pearse"]
  s.email       = ["jon@jonpearse.net"]
  s.homepage    = "http://jonpearse.net/"
  s.summary     = "Textile->HTML pre-rendering for ActiveRecord via RedCloth"
  s.description = "renderable provides a simple hook for ActiveRecord that converts Textile to HTML when the object is saved"

  s.files = Dir["lib/**/*"]

  s.add_dependency "RedCloth"
end
