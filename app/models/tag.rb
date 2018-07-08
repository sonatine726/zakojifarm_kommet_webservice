# == Schema Information
#
# Table name: tags
#
#  id         :bigint(8)        not null, primary key
#  value      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ApplicationRecord
  has_many :message_tag_links, dependent: :destroy
  has_many :messages, through: :message_tag_links
end
