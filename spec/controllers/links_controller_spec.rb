require 'spec_helper'
# require 'rails_helper'
require_relative '../app/controllers/links'
# require_relative '../app/models/link'

RSpec.describe "mini_url-LinksTest", :type => :controller do
  describe "LinksController" do
    describe 'GET index' do
      it 'should get index' do
        
      end
    end

    describe 'GET new' do
      it 'should get new' do
      
      end
    end

    describe 'POST create' do
      it 'should create new link if it does not exist' do
        expect{
          post :create, params: { link: attributes_for(:link) }
        }.to change(Link, :count).by(1)
      end

      context "with an existing url" do
        before :each do
          @link = create(:link, full_url: 'pinterest.com')
          @link.sanitize
          @link.save
        end
        it "does not create a new entry" do
          expect{
            post :create, params: { link: attributes_for(:link, full_url: 'www.pinterest.com') }
          }.to_not change(Link, :count)
        end
      end
    end

    describe 'POST link' do
      it 'should show link' do
      
      end
    end

  end

end
