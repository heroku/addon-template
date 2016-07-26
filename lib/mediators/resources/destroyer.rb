module Mediators::Resources
  class Destroyer < Mediators::Base
    def initialize(resource:)

      # FIXME: Deprovision whatever services your add-on provides relative to
      # this app. This might include removing database rows, files from the
      # filesystem, etc and might actually be an API call.

      @resource = resource
    end

    def call
      @resource.destroy
    end
  end
end
