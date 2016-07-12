if ENV['RACK_ENV'] != 'production'
  require 'bundler/audit/cli'
end

namespace :bundle_audit do
  desc 'Update vulns database and check gems using bundle-audit'
  task :run do
    Bundler::Audit::CLI.new.update
    Bundler::Audit::CLI.new.check
  end
end
