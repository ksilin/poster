# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'poster/version'

Gem::Specification.new do |spec|
  spec.name          = "poster"
  spec.version       = Poster::VERSION
  spec.authors       = ["ksilin"]
  spec.email         = ["konstantin.silin@gmail.com"]
  spec.description   = %q{TODO: Write a gem description}
  spec.summary       = %q{Make my notes to octoposts}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
