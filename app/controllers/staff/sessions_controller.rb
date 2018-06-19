class Staff::SessionsController < Staff::Base
  skip_before_action :check_staff_login, only: [:new, :create]

  include SessionControllerModule
end
