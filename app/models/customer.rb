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
  has_one :home_address, dependent: :destroy
  has_one :work_address, dependent: :destroy

  before_validation do
    self.email_for_index = email.downcase if email
  end

  def password=(raw_password)
    if raw_password.kind_of?(String)
      self.hashed_password = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.hashed_password = nil
    end
  end
end

