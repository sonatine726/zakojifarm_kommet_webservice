require 'spec_helper'

RSpec.shared_examples 'a protected admin index controller' do
  describe '#index' do
    it 'ログインフォームにリダイレクト' do
      get :index
      expect(response).to redirect_to(admin_login_url)
    end
  end
end

RSpec.shared_examples 'a protected admin controller' do
  it_behaves_like 'a protected admin index controller'

  describe '#show' do
    it 'ログインフォームにリダイレクト' do
      get :show, params: {id:1}
      expect(response).to redirect_to(admin_login_url)
    end
  end
end

RSpec.shared_examples 'a protected singular admin controller' do
  describe '#show' do
    it 'ログインフォームにリダイレクト' do
      get :show
      expect(response).to redirect_to(admin_login_url)
    end
  end
end
