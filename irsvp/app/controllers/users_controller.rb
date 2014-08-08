class UsersController < ApplicationController
  # render template: "UsersHelper"
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    params[:birthday] = params[:birthday].to_date
    @user = User.create(params) # will need to be params[:user]
    if any_errors?
      flash[:error] = @current_error
      flash[:first_name] = params[:first_name]
      flash[:last_name] = params[:last_name]
      flash[:birthday] = params[:birthday]
      flash[:username] = params[:username]
      redirect_to root_path
    else
      user = User.where(username: params[:username]).first
      session[:user_id] = user.id
      Event.create(title: "#{user.first_name}'s Birthday", event_start: date_change(params[:birthday]), description: "Birthday!", user_id: user.id)

      redirect_to user_path(user)
    end
  end

  def session
    user = User.where(username: params[:username]).first
    if user && user.password == params[:password]
      session[:user_id] = user.id
    end

    if logged_in?
      redirect_to user_path(user)
    else
     flash[:error_log] = "Your username or password is incorrect!"
     redirect root_path
   end
 end

 def profile
  @user = User.where(username: params[:username]).first
end

def mainpage
  @user = User.where(username: params[:username]).first
end

end
