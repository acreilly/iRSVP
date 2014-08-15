module UsersHelper
  # attr_accessor :current_user, :authenticate
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

  def authenticate(username, password)
    authenticate_or_request_with_http_basic do |u, p|
      u == username &&
      Digest::SHA1.hexdigest(p) == password
    end
  end
  def current_error
    @current_error ||= @user.errors.full_messages if @user.errors.full_messages.any?
  end

  def any_errors?
    current_error
  end
  def date_change(birthday)
    birthday.to_date
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
end
