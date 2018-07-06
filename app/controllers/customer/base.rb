class Customer::Base < ApplicationController
  include SessionControllerModule

  layout 'customer/customer'

  skip_before_action :authenticate_user!

  protected

  def virtual_current_member(id)
    current_customer(id)
  end

  def root_url
    :customer_root
  end

  def login_url
    :customer_login
  end

  def target_model
    Customer
  end

  def session_id
    :customer_member_id
  end

  def last_access_time_id
    :customer_last_access_time
  end

  def session_name
    'カスタマー'
  end

  def login_form
    Staff::LoginForm
  end

  def authenticator
    Customer::Authenticator
  end

  private

  def current_customer(id = nil)
    if id
      @current_customer ||= Customer.find_by(id: id)
    else
      @current_customer
    end
  end

  helper_method :current_customer
end