source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem "puma"
gem "hanami-api", "~> 0.2.0", require: "hanami/api"
gem "awesome_print"

group :development, :test do
  gem "pry-byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :test do
  gem "rspec"
end

group :production do
end
