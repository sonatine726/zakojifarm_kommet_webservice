# == Schema Information
#
# Table name: message_tag_links
#
#  id         :bigint(8)        not null, primary key
#  message_id :bigint(8)        not null
#  tag_id     :bigint(8)        not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :message_tag_link do
    
  end
end
