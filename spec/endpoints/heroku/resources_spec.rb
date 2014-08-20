require "spec_helper"

describe Endpoints::Heroku::Resources do
  include Rack::Test::Methods

  def app
    Endpoints::Heroku::Resources
  end

  before do
    authorize ENV['HEROKU_USERNAME'], ENV['HEROKU_PASSWORD']
    header "Content-Type", "application/json"
  end

  describe "POST /heroku/resources" do
    let(:resource_attributes) { Fabricate.attributes_for(:resource) }
    let(:resource) { double(uuid: resource_attributes['uuid']) }
    let(:params) do
      {
        heroku_id: resource_attributes[:heroku_id],
        plan: resource_attributes[:plan],
        region: resource_attributes[:region],
        callback_url: resource_attributes[:callback_url]
      }
    end

    it "calls the mediator" do
      expect_any_instance_of(Mediators::Resources::Creator).to receive(:call).and_return(resource)
      post "/heroku/resources", MultiJson.encode(params)
      expect(last_response.status).to eq(201)
    end
  end

  describe "PUT /heroku/resources/:id" do
    let!(:resource) { Fabricate(:resource, plan: 'starter') }
    let(:params) do
      {
        heroku_id: resource.heroku_id,
        plan: 'advanced'
      }
    end

    it "calls the mediator" do
      expect_any_instance_of(Mediators::Resources::Updater).to receive(:call).and_return(resource)
      put "/heroku/resources/#{resource.uuid}", MultiJson.encode(params)
      expect(last_response.status).to eq(200)
    end
  end

  describe "DELETE /heroku/resources/:id" do
    let!(:resource) { Fabricate(:resource) }

    it "calls the mediator" do
      expect_any_instance_of(Mediators::Resources::Destroyer).to receive(:call)
      delete "/heroku/resources/#{resource.uuid}"
      expect(last_response.status).to eq(200)
    end
  end
end
