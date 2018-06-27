# == Schema Information
#
# Table name: customers
#
#  id               :bigint(8)        not null, primary key
#  email            :string           not null
#  email_for_index  :string           not null
#  family_name      :string           not null
#  given_name       :string           not null
#  family_name_kana :string           not null
#  given_name_kana  :string           not null
#  gender           :string
#  birthday         :date
#  hashed_password  :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Customer < ApplicationRecord
  include EmailHolder
  include PersonalNameHolder
  include PasswordHolder

  has_one :home_address, dependent: :destroy, autosave: true
  has_one :work_address, dependent: :destroy, autosave: true

  validates :gender,inclusion: { in: %w(male female), allow_blank: true }
  validates :birthday, date: {
    after: Date.new(1900, 1, 1),
    before: ->(obj){ Date.today },
    allow_blank: true
  }
end

