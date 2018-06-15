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

  describe "#update" do
    let(:staff_member){create(:staff_member)}

    it 'suspendedフラグがセットできる' do
      params_hash.merge!(suspended: true)
      patch :update, params: { id: staff_member.id, staff_member: params_hash}
      staff_member.reload
      expect(staff_member).to be_suspended
    end

    it 'hashed_passwordは変更できない' do
      params_hash.delete(:password)
      params_hash.merge!(hashed_password: 'x')
      expect{
        patch :update, params: { id: staff_member.id, staff_member: params_hash}
      }.not_to change{staff_member.hashed_password.to_s}
    end
  end
end
