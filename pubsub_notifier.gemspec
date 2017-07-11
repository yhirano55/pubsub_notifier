$:.push File.expand_path("../lib", __FILE__)
require "pubsub_notifier/version"

Gem::Specification.new do |s|
  s.name        = "pubsub_notifier"
  s.version     = PubsubNotifier::VERSION
  s.authors     = ["Yoshiyuki Hirano"]
  s.email       = ["yhirano@me.com"]
  s.summary     = %q{Pub/Sub Notifier for Ruby on Rails}
  s.description = s.summary
  s.homepage    = "https://github.com/yhirano55/pubsub_notifier"
  s.license     = "MIT"

  s.required_ruby_version = ">= 2.2.0"

  s.add_dependency "activesupport", ">= 3.0.0"
  s.add_dependency "wisper",        ">= 2.0.0"

  s.add_development_dependency "bundler", "~> 1.15"

  s.files         = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files    = Dir["spec/**/*"]
  s.require_paths = ["lib"]
end
