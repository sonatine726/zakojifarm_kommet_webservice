require 'spec_helper'

describe Staff::Admin::TopController, type: :controller do
  context 'ログイン前' do
    it_behaves_like 'a protected admin index controller'
  end

  context 'ログイン後' do
    let(:admin_member){create(:admin_member)}
    before do
      session[:admin_member_id] = admin_member.id
      session[:admin_last_access_time] = 1.second.ago
    end

    describe '#index' do
      it '通常はstaff/top/indexを表示' do
        get :index
        expect(response).to render_template('staff/admin/top/dashboard')
      end

      it '停止フラグがセットされたら強制ログアウト' do
        admin_member.update_column(:suspended, true)
        get :index
        expect(session[:admin_member_id]).to be_nil
        expect(response).to redirect_to(admin_login_url)
      end

      it 'セッションタイムアウト' do
        session[:admin_last_access_time] = Staff::Admin::SessionsController::TIMEOUT.ago.advance(secondes:-1)
        get :index
        expect(session[:admin_member_id]).to be_nil
        expect(response).to redirect_to(admin_login_url)
      end
    end
  end
end
