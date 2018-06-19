class Staff::Admin::SessionsController < Staff::Admin::Base
  skip_before_action :check_admin_login, only: [:new, :create]

  include SessionControllerModule
end
