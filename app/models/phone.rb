# == Schema Information
#
# Table name: phones
#
#  id               :bigint(8)        not null, primary key
#  customer_id      :bigint(8)        not null
#  address_id       :bigint(8)
#  number           :string           not null
#  number_for_index :string           not null
#  primary          :boolean          default(FALSE), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Phone < ApplicationRecord
  include StringNomalizer

  belongs_to :customer, optional: true
  belongs_to :address, optional: true

  before_validation do
    self.number = normalize_as_phone_number(number)
    self.number_for_index = number.gsub(/\D/, '') if number
  end

  before_create do
    self.customer = address.customer if address
  end

  validates :number, presence: true,
    format: { with: /\A\+?\d+(-\d+)*\z/, allow_blank: true}
end
