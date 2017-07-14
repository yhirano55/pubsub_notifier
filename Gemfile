source "https://rubygems.org"

gemspec

gem "appraisal"
gem "pry"
gem "rails", ">= 5.0.0"

group :development, :test do
  gem "sqlite3", platform: :mri
end

group :development do
  gem "onkcop", require: false
end

group :test do
  gem "factory_girl_rails"
  gem "rspec-rails"
end
