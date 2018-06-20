module StaffSessionModule
  extend ActiveSupport::Concern

  include StringNomalizer

  included do
    before_validation do
      self.email_for_index = email.downcase if email
      self.family_name = normalize_as_name(family_name)
      self.given_name = normalize_as_name(given_name)
      self.family_name_kana = normalize_as_furigana(family_name_kana)
      self.given_name_kana = normalize_as_furigana(given_name_kana)
    end
  end

  def password=(raw_password)
    if raw_password.kind_of?(String)
      self.hashed_password = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.hashed_password = nil
    end
  end

  def active?
    !suspended? && start_date <= Date.today &&
      (end_date.nil? || end_date > Date.today)
  end
end
