# == Schema Information
#
# Table name: allowed_sources
#
#  id         :bigint(8)        not null, primary key
#  namespace  :string           not null
#  octet1     :integer          not null
#  octet2     :integer          not null
#  octet3     :integer          not null
#  octet4     :integer          not null
#  wildcard   :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :allowed_source do
    
  end
end
