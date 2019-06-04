
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "yaka/version"

Gem::Specification.new do |spec|
  spec.name          = "yaka"
  spec.version       = Yaka::VERSION
  spec.authors       = ["Igor Pavlov"]
  spec.email         = ["gophan1992@gmail.com"]

  spec.summary       = %q{This is a modern version of yandex kassa implementation}
  spec.description   = %q{This gem is used to receive and process yandex kassa payments.}
  spec.homepage      = "https://github.com/beastia/yaka"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/beastia/yaka"
    spec.metadata["changelog_uri"] = "https://github.com/beastia/yaka/blob/master/CHANGELOG.md"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock"
  spec.add_dependency "pry"
  spec.add_dependency 'dry-configurable'
  spec.add_dependency 'dry-struct'
  spec.add_dependency 'oj'
  spec.add_dependency 'faraday'
  spec.add_development_dependency 'faker'
end
