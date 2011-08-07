require 'rubygems'
require 'rake/gempackagetask'
require 'yaml'

spec = YAML.load <<EOF
--- !ruby/object:Gem::Specification
name: narray
version: !ruby/object:Gem::Version
  version: 0.5.9.9
platform: ruby
authors:
- Masahiro Tanaka
autorequire:
bindir: bin
cert_chain: []

date: 2010-12-14
default_executable:
dependencies: []

description: Numerical N-dimensional Array class
email: masa16.tanaka@gmail.com
executables: []

extensions:
- src/extconf.rb
extra_rdoc_files: []

files:
- src/ChangeLog
- src/MANIFEST
- src/README.en
- src/README.ja
- src/SPEC.en
- src/SPEC.ja
- src/depend
- src/extconf.rb
- src/mkmath.rb
- src/mknafunc.rb
- src/mkop.rb
- src/na_array.c
- src/na_func.c
- src/na_index.c
- src/na_linalg.c
- src/na_random.c
- src/narray.c
- src/narray.def
- src/narray.h
- src/narray_local.h
- src/lib/narray_ext.rb
- src/lib/nmatrix.rb
has_rdoc: true
homepage: http://narray.rubyforge.org/
post_install_message:
rdoc_options: []

require_paths:
- .
required_ruby_version: !ruby/object:Gem::Requirement
  requirements:
  - - ">="
    - !ruby/object:Gem::Version
      version: "0"
  version:
required_rubygems_version: !ruby/object:Gem::Requirement
  requirements:
  - - ">="
    - !ruby/object:Gem::Version
      version: "0"
  version:
requirements: []

rubyforge_project: narray
rubygems_version: 1.0.1
signing_key:
specification_version: 2
summary: N-dimensional Numerical Array class for Ruby
test_files: []

EOF

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_zip = true
  pkg.need_tar = true
  pkg.package_files.each{|x| file x => "src"}
end

file "src" do
  ln_s ".","src"
end

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

desc "Run unit tests"
task :unit_tests do
  ruby "-I.:lib test/unit_tests.rb"
end
