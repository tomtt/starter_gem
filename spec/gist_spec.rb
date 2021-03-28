require 'gist'
require 'open-uri'

RSpec.describe Gist do
  describe "read" do
    it "raises when url is empty" do
      expect(-> { Gist.read("") }).to raise_error Gist::NoValidGistUrlError
    end

    it "raises an error when url does not contain 'gist'" do
      expect(-> { Gist.read("ponypark.com") }).to raise_error Gist::NoValidGistUrlError
    end

    it "reads from full url if it is a raw gist" do
      raw_gist_url = "https://gist.githubusercontent.com/tomtt/2bdafe5e1eeb992bc4bf0ec2e50c6e4e/raw/88105b1716f387614839d0ebab66c71e4d9c94e1/C%2520diatonic%2520notes"
      uri_double = double("uri")
      expect(URI).to receive(:parse).with(raw_gist_url).and_return(uri_double)
      expect(uri_double).to receive(:open).and_return(double('url', read: ""))
      Gist.read(raw_gist_url)
    end
  end
end
