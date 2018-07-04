# == Schema Information
#
# Table name: programs
#
#  id                         :bigint(8)        not null, primary key
#  staff_members_id           :bigint(8)        not null
#  title                      :string           not null
#  description                :text
#  application_start_time     :datetime         not null
#  application_end_time       :datetime         not null
#  min_number_of_participants :integer
#  max_number_of_participants :integer
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

class Program < ApplicationRecord
  has_many :entries, dependent: :destroy
  has_many :applicants, through: :entries, source: :customer
  belongs_to :registrant, class_name: 'StaffMember'

  attr_accessor :application_start_date, :application_start_hour, :application_start_minute,
                :application_end_date, :application_end_hour, :application_end_minute

  scope :listing, -> {
    joins('LEFT JOIN entries ON programs.id = entries.program_id')
      .select('programs.*, COUNT(entries.id) AS number_of_applicants')
      .group('programs.id')
      .order(application_start_time: :desc)
      .includes(:registrant)
  }
end
