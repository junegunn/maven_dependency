# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'maven_dependency/version'

Gem::Specification.new do |spec|
  spec.name          = 'maven_dependency'
  spec.version       = MavenDependency::VERSION
  spec.authors       = ['Junegunn Choi']
  spec.email         = ['junegunn.c@gmail.com']
  spec.summary       = 'Resolve Maven dependencies using maven-dependency-plugin'
  spec.description   = 'Resolve Maven dependencies using maven-dependency-plugin'
  spec.homepage      = 'https://github.com/junegunn/maven_dependency'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
end
