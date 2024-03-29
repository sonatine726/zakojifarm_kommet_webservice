require 'spec_helper'

RSpec.shared_examples 'a protected staff controller' do
  describe '#index' do
    it 'ログインフォームにリダイレクト' do
      get :index
      expect(response).to redirect_to(staff_login_url)
    end
  end
end

RSpec.shared_examples 'a protected singular staff controller' do
  describe '#show' do
    it 'ログインフォームにリダイレクト' do
      get :show
      expect(response).to redirect_to(staff_login_url)
    end
  end
end
