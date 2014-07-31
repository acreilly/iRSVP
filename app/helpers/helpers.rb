helpers do

  def current_user
   @current_user ||= User.find(session[:user_id]) if session[:user_id]
 end

 def logged_in?
  current_user
end

def logout
  session[:user_id] = nil
end

def current_error
  @current_error ||= @user.errors.full_messages if @user.errors.full_messages.any?
end

def any_errors?
  current_error
end

def owners_event?
  Event.where(id: @event.id, user_id: current_user.id).any?
end

def in_past?(event, birthday)
  if birthday.month < Time.now.month
      year = Time.now.year + 1
      birthday_update = "#{year}-#{birthday.month}-#{birthday.day}".to_datetime
      event.update_attributes(event_start: birthday_update)
    else
      year = Time.now.year
      birthday_update = "#{year}-#{birthday.month}-#{birthday.day}".to_datetime
      p birthday
      event.update_attributes(event_start: birthday_update)
    end
end

# def sort_by_date(dates, direction="ASC")
#   sorted = dates.sort
#   sorted.reverse! if direction == "DESC"
#   sorted
# end

def gravatar_image
  email_address = @target_user.email.downcase
  hash = Digest::MD5.hexdigest(email_address)
  image_src = "http://www.gravatar.com/avatar/#{hash}"
end

end