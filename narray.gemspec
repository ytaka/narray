# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "narray/version"

Gem::Specification.new do |s|
  s.name        = "narray"
  s.version     = NArray::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Masahiro TANAKA"]
  s.email       = "masa16.tanaka@gmail.com"
  s.homepage    = "http://narray.rubyforge.org"
  s.summary     = "narray-#{NArray::VERSION}"
  s.description = <<-EOF
    NArray is an Numerical N-dimensional Array class. Supported element types are
    1/2/4-byte Integer, single/double-precision Real/Complex, and Ruby Object. This
    extension library incorporates fast calculation and easy manipulation of large
    numerical arrays into the Ruby language. NArray has features similar to NumPy,
    but NArray has vector and matrix subclasses.
  EOF

  s.rubyforge_project = "narray"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib", "ext"]
  s.extensions     = ["ext/narray/extconf.rb"]

  s.rdoc_options << '--title' << s.name << '--main' << 'README.rdoc' << '--line-numbers' << '--inline-source'
  s.extra_rdoc_files = ['README.rdoc']

  s.add_development_dependency('rake')
  s.add_development_dependency('rake-compiler')
  s.add_development_dependency('rspec', '~> 2')
end
