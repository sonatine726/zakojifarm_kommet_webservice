require 'rails_helper'

RSpec.describe Staff::SessionsController, type: :controller do
  describe '#create' do
    let(:staff_member){create(:staff_member)}

    it '「次回から自動でログインする」にチェックせずにログイン' do
      post :create, params: { 
        staff_login_form: {
          email: staff_member.email,
          password: 'pw'
        }
      }

      expect(session[:staff_member_id]).to eq(staff_member.id)
      expect(response.cookies).not_to have_key('staff_member_id')
    end

    it '「次回から自動でログインする」にチェックしてログイン' do
      post :create, params: {
        staff_login_form: {
          email: staff_member.email,
          password: 'pw',
          remember_me: '1'
        }
      }

      expect(session).not_to have_key(:staff_member_id)
      expect(response.cookies['staff_member_id']).to match(/[0-9a-f]{40}\z/)

      cookies = response.request.env['action_dispatch.cookies'].instance_variable_get(:@set_cookies)
      expect(cookies['staff_member_id'][:expires]).to be > (1.week - 1.day).from_now
    end
  end
end
