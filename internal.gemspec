# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'internal/version'

Gem::Specification.new do |spec|
  spec.name          = 'internal'
  spec.version       = Internal::VERSION
  spec.authors       = ['Daniel da Silva Ferreira (dsferreira)']
  spec.email         = ['daniel.ferreira@dsferreira.com']
  spec.description   = %q{Internal}
  spec.summary       = %q{Makes a class, module or method internal}
  spec.homepage      = ''
  spec.license       = 'MIT'
  spec.files         = IO.read(File.expand_path('../MANIFEST.txt', __FILE__)).split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'binding_of_caller'
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'minitest', '~> 5.0'
end
