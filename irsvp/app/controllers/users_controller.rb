class UsersController < ApplicationController
  include UsersHelper

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      user = User.where(username: @user.username).first
      session[:user_id] = user.id

      Event.create(title: "#{user.first_name}'s Birthday", event_start: date_change(user.birthday), description: "Birthday!", user_id: user.id)

      redirect_to main_path(@user)
    else
      flash[:error] = @current_error
      # flash[:first_name] = params[:first_name]
      # flash[:last_name] = params[:last_name]
      # flash[:birthday] = params[:birthday]
      # flash[:username] = params[:username]
      redirect_to root_path
    end
  end

  def sessions
    user = User.where(username: params[:session][:username]).first
    if user && user.password == params[:session][:password]
      session[:user_id] = user.id
    end

    if session[:user_id] != nil
      redirect_to user_path(user)
    else
     flash[:error_log] = "Your username or password is incorrect!"
     redirect_to root_path
   end
 end

 def profile
   @user = User.where(id: params[:username]).first
 end

 def mainpage
  @user = User.where(id: params[:username]).first
end

def logout
  logout
end
end
