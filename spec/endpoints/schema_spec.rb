require "spec_helper"

RSpec.describe Endpoints::Schema do
  include Rack::Test::Methods

  let(:schema_filename) { "#{Config.root}/schema/schema.json" }

  subject(:get_schema) { get "/schema.json" }

  context "without a schema.json" do
    before do
      allow(File).to receive(:exists?).and_return(false)
    end

    it "raises a 404 on missing schema" do
      expect{ get_schema }.to raise_error(Pliny::Errors::NotFound)
    end
  end

  context "with a schema.json" do
    let(:contents) { "contents" }

    before do
      allow(File).to receive(:exists?).and_return(true)
      allow(File).to receive(:read).and_return(contents)
    end

    it "returns the schema is present" do
      get_schema
      expect(last_response.status).to eq 200
      expect(last_response.headers["Content-Type"]).to eq "application/schema+json"
      expect(last_response.body).to eq contents
    end
  end
end
