get '/users' do
  @users = User.all
  erb :all_users
end

# --------------------CREATE USER
post '/users' do
  params[:birthday] = params[:birthday].to_date
  @user = User.create(params)
  if any_errors?
    flash[:error] = @current_error
    flash[:first_name] = params[:first_name]
    flash[:last_name] = params[:last_name]
    flash[:birthday] = params[:birthday]
    flash[:username] = params[:username]
    redirect '/'
  else
    # User.create(params)
    user = User.find_by(username: params[:username])
    session[:user_id] = user.id
    Event.create(title: "#{user.first_name}'s Birthday", event_start: date_change(params[:birthday]), description: "Birthday!", user_id: user.id)

    redirect "/users/#{current_user.username}"
  end
end

# --------------------LOGIN & VERIFY
post '/sessions' do
  user = User.find_by(username: params[:username])
  if user && user.password == params[:password]
    session[:user_id] = user.id
  end

  if logged_in?
    redirect "/users/#{current_user.username}"
  else
   flash[:error_log] = "Your username or password is incorrect!"
   redirect '/'
 end
end

# --------------------USERS MAIN PAGE
get '/users/:username' do
  @target_user = User.find_by(username: params[:username])
  @users_events = Event.all.where(user_id: session[:user_id])
  @user_following = @target_user.followers
  @events = Event.all
  erb :home
end

# --------------------PROFILE PAGE
get '/profiles/:username' do
  @target_user = User.find_by(username: params[:username])
  @users_events = Event.all.where(user_id: @target_user.id)
  @attending_events = @target_user.attended_events
  @user_following = @target_user.followers
  @user_followers = @target_user.followings
  erb :profile
end

# --------------------LOGOUT
post '/logout' do
  logout
  redirect '/'
end

# --------------------ADDING ATTENDEES
post '/attendees' do
  event = Event.find(params[:event_id])
  attendee_added = User.find_by_username(params[:username])
  event.attendees << attendee_added
  return attendee_added.to_json
end

# --------------------CREATING FOLLOWERS
post '/followings' do
  current_user.followers << User.find(params[:user_id])
  return User.find(current_user.id).to_json
end
