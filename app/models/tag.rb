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
end
