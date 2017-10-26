require "rails_helper"

RSpec.describe Link, :type => :model do
  it "generates a short url" do
    netflix = Link.create!(full_url: "https://netflix.com")

    expect(netflix.short_url).to eq("h")
  end

  it "sanitizes the url" do 
    netflix = Link.create!(full_url: "https://netflix.com")

    expect(netflix.sanitize).to eq("http://netflix.com")
  end

  it "finds duplicate urls" do
    netflix = Link.create!(full_url: "https://netflix.com")

    expect(netflix.find_duplicate.nil?).to eq(false)
  end

  it "should require a valid url" do

    expect(Link.new(:full_url => "hello")).to be_invalid
  end
end