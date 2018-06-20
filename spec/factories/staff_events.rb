# == Schema Information
#
# Table name: staff_events
#
#  id              :bigint(8)        not null, primary key
#  staff_member_id :bigint(8)        not null
#  type            :string           not null
#  created_at      :datetime         not null
#

FactoryBot.define do
  factory :staff_event do
    
  end
end
