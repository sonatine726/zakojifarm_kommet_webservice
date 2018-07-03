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
#  birth_year       :integer
#  birth_month      :integer
#  birth_mday       :integer
#

class Customer < ApplicationRecord
  include EmailHolder
  include PersonalNameHolder
  include PasswordHolder

  has_many :addresses, dependent: :destroy
  has_one :home_address, inverse_of: :customer, autosave: true
  has_one :work_address, inverse_of: :customer, autosave: true
  has_many :phones, dependent: :destroy
  has_many :personal_phones, -> { where(address_id: nil).order(:id) },
    class_name: 'Phone', inverse_of: :customer, autosave: true
  has_many :entries, dependent: :destroy
  has_many :programs, through: :entries

  validates :gender,inclusion: { in: %w(male female), allow_blank: true }
  validates :birthday, date: {
    after: Date.new(1900, 1, 1),
    before: ->(obj){ Date.today },
    allow_blank: true
  }

  before_save do
    if birthday
      self.birth_year = birthday.year
      self.birth_month = birthday.month
      self.birth_mday = birthday.mday
    end
  end
end

