# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mongoid_revisions/version"

Gem::Specification.new do |s|
  s.name        = "mongoid_revisions"
  s.version     = MongoidRevisions::VERSION
  s.authors     = ["Emiliano Della Casa"]
  s.email       = ["e.dellacasa@engim.eu"]
  s.homepage    = "http://github.com/emilianodellacasa/mongoid_revisions"
  s.summary     = %q{Add support for revisions to your Mongoid documents}
  s.description = %q{Add support for revisions to your Mongoid documents by creating a new version of a document every time you change it and replicating all of its associations}

  s.rubyforge_project = "mongoid_revisions"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'mongoid', '~> 2.4.2'
  s.add_development_dependency "rake" 
  s.add_development_dependency 'rspec', '~> 2.8.0'
  s.add_development_dependency 'bson_ext', '~> 1.5.2'
end
