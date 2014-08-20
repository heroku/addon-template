require "spec_helper"

describe Mediators::Resources::Creator do
  let(:resource_attributes) { Fabricate.attributes_for(:resource) }
  let(:resource_creator) { described_class.new(resource_attributes) }

  it "creates a Resource" do
    result = nil
    expect { result = resource_creator.call }.to change(Resource, :count).by(1)
    expect(result).to be_a(Resource)
  end
end
