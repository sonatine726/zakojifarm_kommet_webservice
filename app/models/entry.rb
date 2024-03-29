# == Schema Information
#
# Table name: entries
#
#  id          :bigint(8)        not null, primary key
#  program_id  :bigint(8)        not null
#  customer_id :bigint(8)        not null
#  approved    :boolean          default(FALSE), not null
#  canceled    :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Entry < ApplicationRecord
  belongs_to :program
  belongs_to :customer
end
