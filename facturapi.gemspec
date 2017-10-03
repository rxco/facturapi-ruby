# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'facturapi/version'

Gem::Specification.new do |spec|
  spec.name          = "Facturapi"
  spec.version       =  1
  spec.authors       = ["German Rodriguez"]
  spec.email         = ["germanson@gmail.com"]

  spec.summary       = "FacturAPI makes it easy for developers to generate valid Invoices in Mexico (known as Factura Electrónica or CFDI)"
  spec.description   = "If you've ever used Stripe or Conekta, you'll find FacturAPI very straightforward to understand and integrate in your server app."
  spec.homepage      = "https://facturapi.io"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
