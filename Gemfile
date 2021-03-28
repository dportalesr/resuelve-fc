source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem "puma"
gem "hanami-api", "~> 0.2.0", require: "hanami/api"
gem "hanami-validations"
gem "hanami-controller"
gem "activesupport", require: "active_support"
gem "awesome_print"
gem "rake"

group :development, :test do
  gem "guard-puma"
  gem "guard-standardrb"
  gem "guard-livereload", "~> 2.5", require: false
  gem "pry-byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "raddocs"
end

group :test do
  gem "rack-test"
  gem "rspec"
  gem "rspec_api_documentation"
end

group :production do
end
