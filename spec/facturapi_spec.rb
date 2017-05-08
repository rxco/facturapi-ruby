require "spec_helper"

RSpec.describe Facturapi do
  it "has a version number" do
    expect(Facturapi::VERSION).not_to be nil
  end

  it "Loads API key" do
    Facturapi.api_key = '1tv5yJp3xnVZ7eK67m4h'
    expect(Facturapi.api_key).to eq('1tv5yJp3xnVZ7eK67m4h')
  end
end
