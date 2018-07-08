# == Schema Information
#
# Table name: programs
#
#  id                         :bigint(8)        not null, primary key
#  registrant_id              :bigint(8)        not null
#  title                      :string           not null
#  description                :text
#  application_start_time     :datetime         not null
#  application_end_time       :datetime         not null
#  min_number_of_participants :integer
#  max_number_of_participants :integer
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

FactoryBot.define do
  factory :program do
    title 'Title'
    description 'Description'
    application_start_time { 5.days.ago.midnight }
    application_end_time { 2.days.from_now.midnight }
    min_number_of_participants 5
    max_number_of_participants 10
    registrant { create( :staff_member ) }
  end
end
