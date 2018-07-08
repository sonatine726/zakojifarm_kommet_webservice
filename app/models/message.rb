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

class Message < ApplicationRecord
  belongs_to :customer, optional: true
  belongs_to :staff_member, optional: true
  belongs_to :root, class_name: 'Message', optional: true
  belongs_to :parent, class_name: 'Message', optional: true

  validates :subject, :body, presence: true
  validates :subject, length: { maximum: 80, allow_blank: true }
  validates :body, length: { maximum: 800, allow_blank: true }

  before_create do
    if parent
      self.customer = parent.customer
      self.root = parent.root || parent
    end
  end

  default_scope { order(created_at: :desc) }

  before_validation do
    if parent
      self.root = parent.root || parent
      self.customer = parent.customer
    end
  end

  attr_accessor :child_nodes

  def tree
    return @tree if @tree
    r = root || self
    messages = Message.where(root_id: r.id).select(:id, :parent_id, :subject)
    @tree = SimpleTree.new(r, messages)
  end
end
