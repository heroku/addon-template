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

        # FIXME: If your add-on provides configuration through environment
        # variables (say, for an app to connect to a service you provide),
        # you'd return those here.
        #
        # See: https://devcenter.heroku.com/articles/building-a-heroku-add-on#2-implement-the-provision-call

        status 201
        MultiJson.encode(id: resource.uuid)
      end

      put "/:id" do |id|
        updater = Mediators::Resources::Updater.new(
          resource: @resource,
          plan: body_params['plan']
        )
        updater.call

        # FIXME: If a plan change requires that you issue new credentials,
        # you'd return those credentials here similar to a provisioning
        # request.
        #
        # See: https://devcenter.heroku.com/articles/building-a-heroku-add-on#8-plan-changes

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
