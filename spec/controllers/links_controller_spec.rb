require 'spec_helper'

RSpec.describe "mini_url-LinksTest", :type => :controller do
  
  describe "LinksController" do
    describe 'GET index' do
      it "renders the index template" do
        @controller = LinksController.new
        get :index
        expect(response).to render_template("index")
      end
    end

    describe 'POST create' do
      context "with an existing url" do
        before :each do
          link = Link.create!(full_url: 'https://pinterest.com')
          link.sanitize
          link.save
        end

        it "does not create a new entry" do
          expect{
            Link.new(full_url: "https://pinterest.com")
          }.to_not change(Link, :count)
        end

      end
    end

  end

end
