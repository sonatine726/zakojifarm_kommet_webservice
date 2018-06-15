require 'rails_helper'

RSpec.describe Staff::Admin::StaffMembersController, type: :controller do
  let(:params_hash){attributes_for(:staff_member)}
  before do
    admin_for_test = create(:admin_member)
    session[:admin_member_id] = admin_for_test.id
  end

  describe "#create" do
    it '職員一覧ページにリダイレクト' do
      post :create, params: { staff_member: params_hash }
      expect(response).to redirect_to(admin_staff_members_url)
    end

    it '例外ActionController::ParameterMissingが発生' do
      bypass_rescue
      expect{post :create}.to raise_error(ActionController::ParameterMissing)
    end
  end
end
