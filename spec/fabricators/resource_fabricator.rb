Fabricator(:resource) do
  heroku_id { SecureRandom.uuid }
  plan { "enterprise-#{SecureRandom.uuid}" }
  region { ["amazon-web-services::us-east-1", "amazon-web-services::eu-west-1"].sample }
  callback_url do |attrs|
    "https://api.heroku.com/vendor/apps/#{attrs[:heroku_id]}"
  end
end
