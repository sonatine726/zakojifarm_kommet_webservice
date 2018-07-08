# == Schema Information
#
# Table name: messages
#
#  id              :bigint(8)        not null, primary key
#  customer_id     :bigint(8)        not null
#  staff_member_id :bigint(8)
#  root_id         :bigint(8)
#  parent_id       :bigint(8)
#  type            :string           not null
#  status          :string           default("new"), not null
#  subject         :string           not null
#  body            :text
#  remarks         :text
#  discarded       :boolean          default(FALSE), not null
#  deleted         :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class StaffMessage < Message
end
