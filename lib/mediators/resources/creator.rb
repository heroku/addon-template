module Mediators::Resources
  class Creator < Mediators::Base
    def initialize(heroku_id: heroku_id, plan: plan, region: region, callback_url: callback_url)
      @resource = Resource.new(
        heroku_id: heroku_id,
        plan: plan,
        region: region,
        callback_url: callback_url
      )
    end

    def call
      @resource.save
    end
  end
end
