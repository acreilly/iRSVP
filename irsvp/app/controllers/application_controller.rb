class ApplicationController < ActionController::Base
  # protect_from_forgery
  helper_method :current_user, :logged_in?
def current_user
@current_user ||= User.find_by_id(session[:user])
end

def logged_on?
current_user != nil
  end
end
