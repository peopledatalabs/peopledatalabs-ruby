RSpec.describe Peopledatalabs do
  it "has a version number" do
    expect(Peopledatalabs::VERSION).not_to be nil
  end

  it "has an env api value" do
    expect(ENV['PDL_API_KEY']).not_to be nil
  end

  it "should Return Person Record for a phone" do
    result = Peopledatalabs::Enrichment.person(params: { phone: '4155688415' })
    expect(result['status']).to eq(200)
    expect(result).to be_an_instance_of(Hash)
  end
end
