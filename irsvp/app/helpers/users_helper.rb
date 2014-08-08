module UsersHelper
  def current_user
   @current_user ||= User.find(session[:user_id]) if session[:user_id]
 end

 def logged_in?
  !current_user.nil?
end

def logout
  session.clear
end
end
