# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'straight_outta/version'

Gem::Specification.new do |spec|
  spec.name          = "straight_outta"
  spec.version       = StraightOutta::VERSION
  spec.authors       = ["Matt Moore"]
  spec.email         = ["mattmoore@carbonhelix.com"]

  spec.summary       = %q{Make your own Straight Outta Compton images.}
  spec.description   = %q{Generates Straight Outta Compton images with the text of your choice.}
  spec.homepage      = "https://github.com/mattmoore/straight_outta"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_runtime_dependency "rmagick", "~> 2.16"
end
