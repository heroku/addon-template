module Endpoints
  class Heroku::Resources < Base
    use Middleware::HerokuAuthenticator

    namespace "/heroku/resources" do
      before do
        content_type :json, charset: 'utf-8'
      end

      before "/:id" do |id|
        @resource = Resource[uuid: id]
      end

      post do
        creator = Mediators::Resources::Creator.new(
          heroku_id: body_params['heroku_id'],
          plan: body_params['plan'],
          region: body_params['region'],
          callback_url: body_params['callback_url']
        )
        resource = creator.call

        status 201
        MultiJson.encode(id: resource.uuid)
      end

      put "/:id" do |id|
        updater = Mediators::Resources::Updater.new(
          resource: @resource,
          plan: body_params['plan']
        )
        updater.call

        status 200
        MultiJson.encode({})
      end

      delete "/:id" do |id|
        destroyer = Mediators::Resources::Destroyer.new(resource: @resource)
        destroyer.call

        status 200
        MultiJson.encode({})
      end
    end

  end
end
