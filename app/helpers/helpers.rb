helpers do

  def current_user
   @current_user ||= User.find(session[:user_id]) if session[:user_id]
 end

 def logged_in?
  !current_user.nil?
end

def logout
  session.clear
end

def current_error
  @current_error ||= @user.errors.full_messages if @user.errors.full_messages.any?
end

def any_errors?
  current_error
end

def current_event_error
  @current_error ||= @event.errors.full_messages if @event.errors.full_messages.any?
end

def any_event_errors?
  current_event_error
end

def owners_event?
  Event.where(id: @event.id, user_id: current_user.id).any?
end

def date_change(birthday)

  if birthday.month < Time.now.month
    year = Time.now.year + 1
    "#{year}-#{birthday.month}-#{birthday.day}".to_datetime
  else
    year = Time.now.year
    "#{year}-#{birthday.month}-#{birthday.day}".to_datetime
  end

end

def gravatar_image
  email_address = @user.email.downcase
  hash = Digest::MD5.hexdigest(email_address)
  image_src = "http://www.gravatar.com/avatar/#{hash}"
end

  if production?
    after do
      ActiveRecord::Base.connection.close
    end
  end
end