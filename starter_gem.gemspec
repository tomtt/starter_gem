require_relative "lib/starter_gem/version"

Gem::Specification.new do |spec|
  spec.name = "starter_gem"
  spec.version = StarterGem::VERSION
  spec.authors = ["Tom ten Thij"]
  spec.email = ["code@tomtenthij.nl"]

  spec.summary = "A skeleton to start a gem from"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) {
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Just an example dependency using in example DoSomething class
  spec.add_dependency("curses")
  spec.add_dependency("pastel", "~> 0.8.0")
  spec.add_dependency("zeitwerk")
end
