class DepartmentsController < ApplicationController


  def index
    @departments = Department.all
    render 'index'
  end

  def create
    @user = User.find(current_user.id)
    if @user.admin
      @department = Department.create(params.permit(:name))
      render 'show'
    end
  end

  def show
  end

  def new
    @department = Department.new
  end

  def update
  end

  def destroy
    @department = Department.find(params[:id])
    @tickets = Ticket.where(department_id: @department.id)
    @tickets.each do |ticket|
      ticket.destroy
    end
    @department.destroy
    redirect_to '/department-show'
  end

  def welcome
  end

  def search
    if params[:search].blank?
      redirect_to('/department-show', alert: "Empty field!")
    else
      if Department.where("name LIKE ?", "%" + params[:search] + "%")
        @departments = Department.where("name LIKE ?", "%" + params[:search] + "%")
        render 'search', alert: "Search Results!"
      else
        redirect_to('/department-show', alert: "Not Found!")
      end

    end
  end
end
