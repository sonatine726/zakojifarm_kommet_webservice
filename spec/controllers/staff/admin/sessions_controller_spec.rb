require 'rails_helper'

RSpec.describe Staff::Admin::SessionsController, type: :controller do
  let(:params_hash){attributes_for(:admin_member)}
  before do
    create(:admin_member)
  end

  describe "#create" do
    context 'ログイン成功時' do
      it '管理者ルート画面にリダイレクト' do
        post :create, params: { staff_login_form: params_hash }
        expect(response).to redirect_to(:admin_root)
      end
    end

    context 'params[staff_login_form]が存在しない' do
      it '例外ActionController::ParameterMissingが発生(with bypass_rescue)' do
        bypass_rescue
        expect{post :create}.to raise_error(ActionController::ParameterMissing)
      end
    end
  end
end
