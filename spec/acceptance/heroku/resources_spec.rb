require "spec_helper"

describe Endpoints::Heroku::Resources do
  include Committee::Test::Methods
  include Rack::Test::Methods

  def app
    Routes
  end

  let(:resource_attributes) { Fabricate.attributes_for(:resource) }
  let(:params) do
    {
      heroku_id: resource_attributes[:heroku_id],
      plan: resource_attributes[:plan],
      region: resource_attributes[:region],
      callback_url: resource_attributes[:callback_url]
    }
  end

  before do
    authorize ENV['HEROKU_USERNAME'], ENV['HEROKU_PASSWORD']
    header "Content-Type", "application/json"
  end

  describe "POST /heroku/resources" do

    it "returns the resource id" do
      post "/heroku/resources", MultiJson.encode(params)
      response = MultiJson.decode(last_response.body)
      expect(last_response.status).to eq(201)
      expect(Resource[uuid: response['id']]).not_to be_nil
    end

    it "returns config"

  end

  describe "PUT /heroku/resources/:id" do
    let!(:resource) { Fabricate(:resource, plan: "starter") }
    let(:new_plan) { "advanced" }

    it "updates the resource plan" do
      put "/heroku/resources/#{resource.uuid}", MultiJson.encode(plan: new_plan)
      response = MultiJson.decode(last_response.body)
      expect(last_response.status).to eq(200)
      expect(Resource[uuid: resource.uuid].plan).to eq(new_plan)
    end

  end

  describe "DELETE /heroku/resources/:id" do
    let!(:resource) { Fabricate(:resource) }

    it "destroys the resource" do
      delete "/heroku/resources/#{resource.uuid}"
      response = MultiJson.decode(last_response.body)
      expect(last_response.status).to eq(200)
      expect(Resource[uuid: resource.uuid]).to be_nil
    end

  end

end
