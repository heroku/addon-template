module Mediators::Resources
  class Destroyer < Mediators::Base
    def initialize(resource:)
      @resource = resource
    end

    def call
      @resource.destroy
    end
  end
end
