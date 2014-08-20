module Middleware
  class HerokuAuthenticator
    def initialize(app)
      @app = app
    end

    def call(env)
      auth = Rack::Auth::Basic::Request.new(env)
      unless auth.provided? && auth.basic? && auth.credentials &&
          auth.credentials == [ENV['HEROKU_USERNAME'], ENV['HEROKU_PASSWORD']]
        raise Pliny::Errors::Unauthorized
      end
      @app.call(env)
    end
  end
end
