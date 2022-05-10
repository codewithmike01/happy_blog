#  class user Controller
class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(current_user.id)
    @user
  end

  def new
    @user = User.new
  end
end
