# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rack-ie-redirect-fix/version"

Gem::Specification.new do |s|
  s.name        = "rack-ie-redirect-fix"
  s.version     = Rack::IeRedirectFix::VERSION
  s.authors     = ["Mike Nicholaides"]
  s.email       = ["mike@ablegray.com"]
  s.homepage    = "https://github.com/nicholaides/rack-ie-redirect-fix"
  s.summary     = %q{Fixes an obscure issue with redirects that happens with IE and SSL}
  s.description = %q{}

  s.rubyforge_project = "rack-ie-redirect-fix"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_development_dependency "rack-test"
end
