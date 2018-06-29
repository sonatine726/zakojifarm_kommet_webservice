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

FactoryBot.define do
  factory :phone do
    
  end
end
