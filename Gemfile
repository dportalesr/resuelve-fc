source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem "puma"
gem "hanami-api", "~> 0.2.0", require: "hanami/api"
gem "hanami-validations"
gem "awesome_print"

group :development, :test do
  gem "guard-puma"
  gem "guard-standardrb"
  gem "guard-livereload", "~> 2.5", require: false
  gem "pry-byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :test do
  gem "rspec"
  gem "rspec_api_documentation"
end

group :production do
end
