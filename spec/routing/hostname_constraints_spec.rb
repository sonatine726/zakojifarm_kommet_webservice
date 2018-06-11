require 'spec_helper'

describe 'ルーティング' do
  context 'アクセス可能なルート' do
    it '職員トップページ' do
      expect(get: 'http://kommet.com/staff').to route_to(
        host: 'kommet.com',
        controller: 'staff/top',
        action: 'index'
      )
    end

    it '管理者ログインフォーム' do
      expect(get: 'http://kommet.com/admin/login').to route_to(
        host: 'kommet.com',
        controller: 'staff/admin/sessions',
        action: 'new'
      )
    end
  end

  context 'アクセスできないルート' do
    context 'ホスト名が対象外' do
      it 'errors/not_foundへルーティング' do
        expect(get: 'http://localhost/staff').to route_to(
          controller: 'errors',
          action: 'routing_error',
          anything: 'staff'
        )
      end
    end

    context '存在しないパス' do
      it 'errors/not_foundへルーティング' do
        expect(get: 'http://kommet.com/ng_path').to route_to(
          controller: 'errors',
          action: 'routing_error',
          anything: 'ng_path'
        )
      end
    end
  end
end