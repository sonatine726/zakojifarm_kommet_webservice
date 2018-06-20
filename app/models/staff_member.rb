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

class StaffMember < ApplicationRecord
  include StaffSessionModule

  has_many :events, class_name: 'StaffEvent', dependent: :destroy

  KATAKANA_REGEXP = /\A[\p{katakana}\u{30fc}]+\z/

  validates :family_name, :given_name, presence: true
  validates :family_name_kana, :given_name_kana, presence: true,
    format: {with: KATAKANA_REGEXP, allow_blank: true}
end
