class UsersController < ApplicationController

  skip_before_action :authorized, only: [:new, :create]
  def new
    @user = User.new
  end

  def create
    @username = params.permit(:username)['username']
    unless User.exists?(username: @username)
      if params[:calls_check].eql?('1')
        @admin = params.permit(:username, :password)
        @admin['admin'] = true
        @user = User.create(@admin)
        redirect_to '/admin-welcome', notice: "Your account has been created as an admin and now you are logged in #{@user.username}"
      else

        @user = User.create(params.permit(:username, :password))
        session[:user_id] = @user.id
        redirect_to welcome_path, notice: "Your account has been created and now you are logged in #{@user.username}"
      end
    else
      redirect_to '/users/new', notice: "User already exists"
    end
  end
end
