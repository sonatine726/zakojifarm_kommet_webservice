module FeatureSpecHelper
  def switch_namespace(namespace)
    config = Rails.application.config.kommet
    Capybara.app_host = 'http://' + config[namespace][:host]
  end

  def login_as_staff_member(staff_member, password = 'pw')
    visit staff_login_path
    within('#new_staff_login_form') do
      fill_in 'staff_login_form_email', with: staff_member.email
      fill_in 'staff_login_form_password', with: password
      click_button 'ログイン'
    end
  end

  def login_as_customer(customer, password = 'password')
    visit customer_login_path
    within('#new_staff_login_form') do
      fill_in 'staff_login_form_email', with: customer.email
      fill_in 'staff_login_form_password', with: password
      click_button 'ログイン'
    end
  end
end