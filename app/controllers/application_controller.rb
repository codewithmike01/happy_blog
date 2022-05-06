# class Application Controller
class ApplicationController < ActionController::Base
  add_flash_types :success, :error

  def current_user
    @user = User.first
    @user
  end
end
