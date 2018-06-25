# == Schema Information
#
# Table name: addresses
#
#  id            :bigint(8)        not null, primary key
#  customer_id   :bigint(8)
#  type          :string           not null
#  postal_code   :string           not null
#  prefecture    :string           not null
#  city          :string           not null
#  address1      :string           not null
#  address2      :string           not null
#  company_name  :string           default(""), not null
#  division_name :string           default(""), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryBot.define do
  factory :home_address do
    postal_code '1000000'
    prefecture '東京都'
    city '千代田区'
    address1 '試験1-1-1'
    address2 ''
  end

  factory :work_address do
    company_name 'テスト'
    division_name '開発部'
    postal_code '1050000'
    prefecture '東京都'
    city '港区'
    address1 '試験1-1-2'
    address2 '11'
  end
end
