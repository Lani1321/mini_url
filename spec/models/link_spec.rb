require "rails_helper"

RSpec.describe Link, '#sanitize', :type => :model do
  it "sanitizes the url" do 
    netflix = Link.create!(full_url: "https://netflix.com")

    expect(netflix.sanitize).to eq("http://netflix.com")
  end
end

RSpec.describe Link, '#find_duplicate', :type => :model do
  it "finds duplicate urls" do
    netflix = Link.create!(full_url: "https://netflix.com")

    expect(netflix.find_duplicate.nil?).to eq(false)
  end 
end

RSpec.describe Link, '#valid_url', :type => :model do
  it "should require a valid url" do
    expect(Link.new(:full_url => "hello")).to be_invalid
  end
end