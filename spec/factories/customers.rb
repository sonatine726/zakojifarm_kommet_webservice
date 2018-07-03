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

FactoryBot.define do
  factory :customer do
    sequence(:email) { |n| "member#{n}@example.jp" }
    family_name '山田'
    given_name '太郎'
    family_name_kana 'ヤマダ'
    given_name_kana 'タロウ'
    password 'password'
    birthday Date.new(1970, 1, 1)
    gender 'male'

    trait :with_home_and_work_addresses do
      association :home_address, strategy: :build
      association :work_address, strategy: :build
    end
  end
end
