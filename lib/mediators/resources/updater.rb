module Mediators::Resources
  class Updater < Mediators::Base
    def initialize(resource:, plan:)

      # FIXME: Make whatever changes are necessary to modify an add-on plan
      # linked to an app.

      @resource = resource
      @plan_name = plan
    end

    def call
      @resource.update(plan: @plan_name)
      @resource.save
    end
  end
end
