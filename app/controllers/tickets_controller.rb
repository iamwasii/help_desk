class TicketsController < ApplicationController

  # strong-params
  # report for users
  # search using like



  def new
    @ticket = Ticket.new
  end

  def index
    @user = User.find(current_user.id)
    if @user.admin
      @tickets = Ticket.all
    else
      @tickets = Ticket.where('user_id': current_user.id)
    end
    render 'tickets'
  end

  def show
  end

  def create
    @department = Department.find_by(name: params[:department_name])
    @new_ticket = params.permit(:subject, :body)
    @new_ticket['department_id'] = @department.id
    @new_ticket['user_id'] = current_user.id
    @ticket = Ticket.create(@new_ticket)
    render 'show'
  end

  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy
    redirect_to :controller => 'tickets', :action => 'index'
  end

  def resolve
    @ticket = Ticket.find(params[:id])
    @ticket.status = true
    @ticket.save
    redirect_to :controller => 'tickets', :action => 'index'
  end
end
