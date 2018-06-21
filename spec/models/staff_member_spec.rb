# == Schema Information
#
# Table name: staff_members
#
#  id               :bigint(8)        not null, primary key
#  email            :string           not null
#  email_for_index  :string           not null
#  family_name      :string           not null
#  given_name       :string           not null
#  family_name_kana :string           not null
#  given_name_kana  :string           not null
#  hashed_password  :string
#  start_date       :date             not null
#  end_date         :date
#  suspended        :boolean          default(FALSE), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

RSpec.describe StaffMember, type: :model do
  describe '#password=' do
    context '文字列を与える' do
      let(:member) {StaffMember.new}
      it 'hashed_passwordは長さ60の文字列になる' do
        member.password = 'test'
        expect(member.hashed_password).to be_kind_of(String)
        expect(member.hashed_password.size).to eq(60)
      end
    end

    context 'nilを与える' do
      let(:member) {StaffMember.new}
      it 'hashed_passwordはnilになる' do
        member.password = nil
        expect(member.hashed_password).to be_nil
      end
    end
  end

  describe '値の正規化' do
    it 'email前後の空白を除去' do
      member = create(:staff_member, email: ' test@example.com ')
      expect(member.email).to eq('test@example.com')
    end

    it 'emailに含まれる全角英数字記号を半角に変換' do
      member = create(:staff_member, email: 'ｔｅｓｔ＠ｅｘａｍｐｌｅ．ｃｏｍ')
      expect(member.email).to eq('test@example.com')
    end

    it 'email前後の全角スペースを除去' do
      member = create(:staff_member, email: "\u{3000}test@example.com\u{3000}")
      expect(member.email).to eq('test@example.com')
    end

    it 'family_name_kanaに含まれるひらがなをカタカナに変換' do
      member = create(:staff_member, family_name_kana: 'てすと')
      expect(member.family_name_kana).to eq('テスト')
    end

    it 'family_name_kanaに含まれる半角カナを全角カナに変換' do
      member = create(:staff_member, family_name_kana: 'ﾃｽﾄ')
      expect(member.family_name_kana).to eq('テスト')
    end
  end

  describe 'バリデーション' do
    it '@を２個含むemailは無効' do
      member = build(:staff_member, email: 'test@@example.com')
      expect(member).not_to be_valid
    end

    it '漢字を含むfamily_name_kanaは無効' do
      member = build(:staff_member, family_name_kana: '試験')
      expect(member).not_to be_valid
    end

    it '長音符を含むfamily_name_kanaは有効' do
      member = build(:staff_member, family_name_kana: 'エリー')
      expect(member).to be_valid
    end

    it '他職員のメールアドレスと重複したemailは無効' do
      member1 = create(:staff_member)
      member2 = build(:staff_member, email: member1.email)
      expect(member2).not_to be_valid
    end
  end
end
