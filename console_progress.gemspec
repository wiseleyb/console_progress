# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'console_progress/version'

Gem::Specification.new do |spec|
  spec.name          = "console_progress"
  spec.version       = ConsoleProgress::VERSION
  spec.authors       = ["Ben Wiseley"]
  spec.email         = ["wiseleyb@gmail.com"]

  spec.summary       = 'Simple progress gem for use in logs/console'
  spec.description   = 'Simple progress gem for use in logs/console'
  spec.homepage      = 'https://github.com/wiseleyb/console_progress'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
