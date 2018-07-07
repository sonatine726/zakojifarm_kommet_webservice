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
end
