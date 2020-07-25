class SessionsController < ApplicationController

  skip_before_action :authorized, only: [:new, :create, :welcome]
  def new
  end

  def show
  end

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      if @user.admin
        redirect_to '/admin-welcome', notice: "You are logged in as admin Mr. #{@user.username}"
      else
        @departments = Department.all
        puts @departments
        render 'welcome', notice: "You are logged in #{@user.username}", :object => @departments
      end
    else
      redirect_to '/login'
    end
  end

  def login
  end

  def page_requires_login
  end

  def admin_welcome
    render 'admin-welcome'
  end

  def welcome
    @departments = Department.all
  end
end
