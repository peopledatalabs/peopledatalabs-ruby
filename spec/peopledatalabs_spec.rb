RSpec.describe Peopledatalabs do
  it "has a version number" do
    expect(Peopledatalabs::VERSION).not_to be nil
  end

  it "has an env api value" do
    expect(ENV['PDL_API_KEY']).not_to be nil
  end
end
