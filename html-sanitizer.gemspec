# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'html/sanitizer/version'

Gem::Specification.new do |spec|
  spec.name          = "html-sanitizer"
  spec.version       = Html::Sanitizer::VERSION
  spec.authors       = ["Dieter Pisarewski", "Rafael Mendonça França", "Kasper Timm Hansen"]
  spec.email         = [ "dieter.pisarewski@gmail.com", "rafaelmfranca@gmail.com", "kaspth@gmail.com"]
  spec.description   = %q{HTML sanitization}
  spec.summary       = %q{This gem is responsible to sanitize HTML fragments.}
  spec.homepage      = "https://github.com/dpisarewski/html-sanitizer"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*", "README.md", "LICENSE.txt", "CHANGELOG.md"]
  spec.test_files    = Dir["test/**/*"]
  spec.require_paths = ["lib"]

  spec.add_dependency "loofah", "~> 2.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "rails-dom-testing"
end
