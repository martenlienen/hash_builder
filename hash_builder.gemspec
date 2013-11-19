# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hash_builder/version'

Gem::Specification.new do |spec|
  spec.name          = "hash_builder"
  spec.version       = HashBuilder::VERSION
  spec.authors       = ["Marten Lienen"]
  spec.email         = ["marten.lienen@gmail.com"]
  spec.description   = %q{Build hashes with the full power of ruby at your fingertips}
  spec.homepage      = "https://github.com/CQQL/hash_builder"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.4"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
