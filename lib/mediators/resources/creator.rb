module Mediators::Resources
  class Creator < Mediators::Base
    def initialize(heroku_id:, plan:, region:, callback_url:)

      # FIXME: Provision whatever services your add-on provides here.
      # Provisioning might be an API call to a service you've created
      # elsewhere. If you need to persist state about whatever you've
      # provisioned in the context of an app, it probably makes sense to add
      # that as an additional column to the Resource model below.

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
