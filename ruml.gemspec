# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ruml/version"

Gem::Specification.new do |s|
  s.name        = "ruml"
  s.version     = Ruml::VERSION
  s.authors     = ["Peter Leitzen"]
  s.email       = ["peter-ruml@suschlik.de"]
  s.homepage    = "https://github.com/splattael/ruml"
  s.summary     = %q{Ruby mailing list software}
  s.description = %q{}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rake",        "~> 0.9.2"
  s.add_development_dependency "minitest",    "~> 5.11.2"

  s.add_runtime_dependency "mail",            "~> 2.7.0"
  s.add_runtime_dependency "moneta",          "~> 1.0.0"
end
