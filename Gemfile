source "https://rubygems.org"
ruby "2.3.1"

gem "multi_json"
gem "oj"
gem "pg"
gem "pliny", "~> 0.28", ">= 0.28.0"
gem "pry"
gem "pry-doc"
gem "puma"
gem "rack-ssl"
gem "rack-timeout", "~> 0.4"
gem "rake"
gem "rollbar", require: "rollbar/middleware/sinatra"
gem "sequel", "~> 4.34"
gem "sequel-paranoid"
gem "sequel_pg", "~> 1.6", require: "sequel"
gem "sinatra", "~> 1.4", require: "sinatra/base"
gem "sinatra-contrib", require: ["sinatra/namespace", "sinatra/reloader"]
gem "sinatra-router"
gem "sucker_punch"

group :development, :test do
  gem "fabrication"
  gem "pry-byebug"
  gem "bundler-audit", require: false
end

group :development do
  gem "foreman"
  gem "kensa"
end

group :test do
  gem "simplecov", require: false
  gem "committee"
  gem "database_cleaner"
  gem "dotenv"
  gem "rack-test"
  gem "rspec"
end
