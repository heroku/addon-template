require "spec_helper"

describe Resource do
  let(:resource) { described_class.new }

  it "must have a heroku_id" do
    resource.heroku_id = nil
    expect(resource).not_to be_valid
    expect(resource.errors).to have_key(:heroku_id)
  end

  it "must have a unqiue heroku_id" do
    existing = Fabricate :resource
    resource = Fabricate.build(:resource, heroku_id: existing.heroku_id)

    expect(resource).not_to be_valid
    expect(resource.errors[:heroku_id]).to include("is already taken")
  end

  it "must have a plan" do
    resource.plan = nil
    expect(resource).not_to be_valid
    expect(resource.errors).to have_key(:plan)
  end

  it "must have a region" do
    resource.region = nil
    expect(resource).not_to be_valid
    expect(resource.errors).to have_key(:region)
  end

  it "must have a callback_url" do
    resource.callback_url = nil
    expect(resource).not_to be_valid
    expect(resource.errors).to have_key(:callback_url)
  end

end
