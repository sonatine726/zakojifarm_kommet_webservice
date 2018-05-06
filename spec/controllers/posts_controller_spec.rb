require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  describe "GET #create" do
    it "returns http success" do
      pending 'Not update test yet.'
      get :create
      expect(response).to have_http_status(:success)
    end
  end

end
