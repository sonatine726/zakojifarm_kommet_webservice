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
#  role                   :integer          default("user"), not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'ユーザーの生年月日が返されること' do
    user = User.new(email: 'hoge@example.com', created_at: Time.utc(2015, 1, 1, 12, 0, 0))
    expect(user.created_month).to eq '2015年01月'
  end
end
