# == Schema Information
#
# Table name: admin_members
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

RSpec.describe AdminMember, type: :model do
  describe '#password=' do
    context '文字列を与える' do
      let(:member) {AdminMember.new}
      it 'hashed_passwordは長さ60の文字列になる' do
        member.password = 'test'
        expect(member.hashed_password).to be_kind_of(String)
        expect(member.hashed_password.size).to eq(60)
      end
    end

    context 'nilを与える' do
      let(:member) {AdminMember.new}
      it 'hashed_passwordはnilになる' do
        member.password = nil
        expect(member.hashed_password).to be_nil
      end
    end
  end
end
