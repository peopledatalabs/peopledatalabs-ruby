
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "peopledatalabs/version"

Gem::Specification.new do |spec|
  spec.name          = "peopledatalabs"
  spec.version       = Peopledatalabs::VERSION
  spec.authors       = ["People Data Labs"]
  spec.email         = ["hello@peopledatalabs.com"]

  spec.summary       = "Official Ruby client for the People Data Labs API."
  spec.description   = "People Data Labs builds people data. Use our dataset of 1.5 Billion unique person profiles to build products, enrich person profiles, power predictive modeling/ai, analysis, and more."
  spec.homepage      = "https://www.peopledatalabs.com"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/peopledatalabs/peopledatalabs-ruby"
    spec.metadata["github_repo"] = "https://github.com/peopledatalabs/peopledatalabs-ruby"
    spec.metadata["documentation_uri"] = "https://docs.peopledatalabs.com"
    spec.metadata["bug_tracker_uri"] = "https://github.com/peopledatalabs/peopledatalabs-ruby/issues"
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

  spec.add_development_dependency "bundler", "~> 2.3"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_runtime_dependency "http", "~> 5.0"
  spec.add_runtime_dependency "forwardable", "~> 1.3"
end
