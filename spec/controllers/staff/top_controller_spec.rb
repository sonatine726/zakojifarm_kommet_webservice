require 'spec_helper'

describe Staff::TopController, type: :controller do
  context 'ログイン前' do
    it_behaves_like 'a protected staff controller'
  end

  context 'ログイン後' do
    let(:staff_member){create(:staff_member)}
    before do
      session[:staff_member_id] = staff_member.id
      session[:staff_last_access_time] = 1.second.ago
    end

    describe '#index' do
      it '通常はstaff/top/dashboardを表示' do
        get :index
        expect(response).to render_template('staff/top/dashboard')
      end

      it '停止フラグがセットされたら強制ログアウト' do
        staff_member.update_column(:suspended, true)
        get :index
        expect(session[:staff_member_id]).to be_nil
        expect(response).to redirect_to(staff_login_url)
      end

      it 'セッションタイムアウト' do
        session[:staff_last_access_time] = Staff::SessionsController::TIMEOUT.ago.advance(secondes:-1)
        get :index
        expect(session[:staff_member_id]).to be_nil
        expect(response).to redirect_to(staff_login_url)
      end
    end
  end
end
