require 'rails_helper'

RSpec.describe WelcomeController do

  describe "GET index" do

    it 'returns 200 when loading welcome page' do
      get :welcome
      expect(response).to be_ok
    end

  end

end
