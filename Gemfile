source "https://rubygems.org"
ruby "2.7.2"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem "puma"
gem "hanami-api", "~> 0.2.0", require: "hanami/api"
gem "hanami-validations"
gem "hanami-controller"
gem "activesupport", require: "active_support"
gem "rack-cors", require: "rack/cors"
gem "rack-attack", require: "rack/attack"
gem "awesome_print"
gem "rake"
gem "raddocs"

group :development, :test do
  gem "guard-puma"
  gem "guard-standardrb"
  gem "guard-livereload", "~> 2.5", require: false
  gem "pry-byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :test do
  gem "rack-test"
  gem "rspec"
  gem "rspec_api_documentation"
end

group :production do
  gem "rack-ssl-enforcer"
end
