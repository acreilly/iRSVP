get '/users' do
  @users = User.all
  erb :all_users
end

# --------------------CREATE USER
post '/users' do
  @user = User.create(params)
  if any_errors?
    flash[:error] = @current_error
    flash[:first_name] = params[:first_name]
    flash[:last_name] = params[:last_name]
    flash[:birthday] = params[:birthday]
    flash[:username] = params[:username]
    redirect '/'
  else
    User.create(params)

    user = User.find_by(username: params[:username])
    session[:user_id] = user.id

    Event.create(title: "#{user.first_name}'s Birthday", event_start: params[:birthday], description: "Birthday!", user_id: user.id)
    birthday_event = Event.find_by_event_start(params[:birthday])
    event_start = birthday_event.event_start
    in_past?(birthday_event, event_start)

    redirect "/users/#{current_user.id}"
  end
end

# --------------------LOGIN & VERIFY
post '/sessions' do
  user = User.find_by(username: params[:username])
  if user && user.password == params[:password]
    session[:user_id] = user.id
  end

  if logged_in?
    redirect "/users/#{current_user.id}"
  else
   flash[:error_log] = "Your username or password is incorrect!"
   redirect '/'
 end
end

# --------------------USERS MAIN PAGE
get '/users/:user_id' do
  @target_user = User.find(params[:user_id])
  @users_events = Event.all.where(user_id: session[:user_id])
  @user_following = @target_user.followers
  @events = Event.all
  @events_sorted = Event.all.sort_by &:event_start
  erb :home
end

get '/profile/:user_id' do
  @target_user = User.find(params[:user_id])
  @users_events = Event.all.where(user_id: params[:user_id])
  @attending_events = @target_user.attended_events
  @user_following = @target_user.followers
  @user_followers = @target_user.followings
  erb :profile
end

post '/logout' do
  logout
  redirect '/'
end

post '/attendees' do
  event = Event.find(params[:event_id])
  attendee_added = User.find_by_username(params[:username])
  event.attendees << attendee_added
  return attendee_added.to_json
end

post '/followings' do
  current_user.followers << User.find(params[:user_id])
  return User.find(current_user.id).to_json
end

# NOT PART OF MVP VV

get '/users/:id/edit' do
  # PAGE WITH EDIT SELF FORM
end

put '/users/:id' do
  #update user info
end

delete '/users/:id' do
  #delete your account with warning "you cannot undo this"
end

get '/map' do
  erb :map_test
end