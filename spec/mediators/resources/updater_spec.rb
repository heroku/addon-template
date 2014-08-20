require "spec_helper"

describe Mediators::Resources::Updater do
  let(:resource) { Fabricate(:resource, plan: 'starter') }
  let(:resource_updater) { described_class.new(resource: resource, plan: 'advanced') }

  it "creates a Resource" do
    expect(resource.plan).to eq('starter')
    resource_updater.call
    expect(resource.reload.plan).to eq('advanced')
  end
end
