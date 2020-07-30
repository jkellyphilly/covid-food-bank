require 'rails_helper'
require 'pry'

RSpec.describe CommunityMembersController do
  describe "community member signup" do

    it 'loads the signup page' do
      get :new
      expect(response).to be_ok
    end

    it 'successful signup directs user to their profile' do
      member_params = {
        :community_member => {
          :username => "skittles123",
          :email => "skittles@aol.com",
          :password => "rainbows",
          :phone_number => "2155144269",
          :address => "101 Main Street",
          :allergies => "shellfish",
          :name => "Skittles"
        }
      }
      post :create, params: member_params
      member = CommunityMember.find_by(username: "skittles123")
      expect(response).to redirect_to community_member_path(member)
    end

    it 'does not let a member sign up without a username' do
      member_params = {
        :community_member => {
          :username => "",
          :email => "skittles@aol.com",
          :password => "rainbows",
          :phone_number => "2155144269",
          :address => "101 Main Street",
          :allergies => "shellfish",
          :name => "Skittles"
        }
      }
      post :create, params: member_params
      member = CommunityMember.find_by(email: "skittles@aol.com")
      expect(member).to eq(nil)
    end

    it 'does not let a member sign up without a password' do
      member_params = {
        :community_member => {
          :username => "skittles123",
          :email => "skittles@aol.com",
          :phone_number => "2155144269",
          :address => "101 Main Street",
          :allergies => "shellfish",
          :name => "Skittles"
        }
      }
      post :create, params: member_params
      member = CommunityMember.find_by(username: "skittles123")
      expect(member).to eq(nil)
    end

    it 'does not let a member sign up without an email' do
      member_params = {
        :community_member => {
          :username => "skittles123",
          :password => "rainbows",
          :phone_number => "2155144269",
          :address => "101 Main Street",
          :allergies => "shellfish",
          :name => "Skittles"
        }
      }
      post :create, params: member_params
      member = CommunityMember.find_by(username: "skittles123")
      expect(member).to eq(nil)
    end

    # TODO: need to add to the above tests & ensure that the user is still viewing the content of the :new action
  end

end
