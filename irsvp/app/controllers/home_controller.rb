class HomeController < ApplicationController
  def index
    @user = User.new
    # if logged_in?
    #   redirect "/users/#{current_user.username}"
    # else
    #   redirect_to root_path
    # end
  end
end
