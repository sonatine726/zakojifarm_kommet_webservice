require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe "GET #create" do
    context "valid post" do
      let(:user){FactoryBot.create(:user)}
      before do
        user.confirm
        sign_in user
        post :create, params: { post: {body: 'test'} }
      end

      its(:response) {is_expected.to have_http_status(302)}
      its(:response) {is_expected.to redirect_to(:root)}
      it { should set_flash[:notice].to('Post was successfully created.')}
    end
  end

end
