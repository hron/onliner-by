# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'onliner_by/version'

Gem::Specification.new do |spec|
  spec.name          = 'onliner-by'
  spec.version       = OnlinerBy::VERSION
  spec.authors       = ['Aleksei Gusev']
  spec.email         = ['aleksei.gusev@gmail.com']

  spec.summary       = 'Scripts to automate some things on onliner.by'
  spec.description   = 'Scripts to automate some things on onliner.by'
  spec.homepage      = 'https://github.com/hron/onliner-by'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pry'
  spec.add_dependency 'capybara'
  spec.add_dependency 'capybara-webkit'
end
