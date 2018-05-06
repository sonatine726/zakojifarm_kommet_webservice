# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  avatar_file_name       :string
#  avatar_content_type    :string
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  posts_count            :integer          default(0), not null
#

class User < ApplicationRecord
  has_many :posts, inverse_of: :user
  validates :name,
            presence: true,
            uniqueness: {case_sensitive: false}

  validates_format_of :name, with: /^[a-zA-Z0-9_\.]*$/, multiline: true
  validate :validate_name

  attr_accessor :login
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable

  def login=(login)
    @login = login
  end

  def login
    @login || self.name || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    conditions[:email].downcase! if conditions[:email]
    login = conditions.delete(:login)

    where(conditions.to_hash).where(["lower(name) = :value OR lower(email) = :value", {value: login.downcase}]).first
  end

  def validate_name
    errors.add(:name, :invalid) if User.where(email: name).exists?
  end

  def created_month
    created_at.strftime('%Y年%m月')
  end

  has_attached_file :avatar,
                    styles: { medium: '300x300>', thumb: '100x100>'},
                    default_url: '/missing.png'

  validates_attachment_content_type :avatar, 
                                    content_type: %r{\Aimage\/.*\z}
end

