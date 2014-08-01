# --------------------CREATE EVENT PAGE & FORM
get '/events/new' do

  erb :create_event
end

# --------------------CREATE EVENT
post '/events' do
  params[:event_start].to_datetime
  params[:event_finish].to_datetime
  @event = Event.create(params)
  @event.user_id = session[:user_id]
  @event.save
  redirect "/events/#{@event.id}"
end

# ----------------------------SHOW EVENT
get '/events/:event_id' do
  @user = User.all
  @current_users_friends = current_user.followings
  @event = Event.find(params[:event_id])

  erb :single_event
end

# ----------------------------SHOW EDIT EVENT FORM
get '/events/:event_id/edit' do
  @event = Event.find(params[:event_id])

  erb :edit_event
end

# ----------------------------UPDATE EVENT
put '/events/:event_id' do
  event = Event.find(params[:event_id])
  event.update_attributes(
    title: params[:title],
    event_start: params[:event_start],
    event_finish: params[:event_finish],
    location: params[:location],
    latitude: params[:latitude],
    longitude: params[:longitude],
    description: params[:description])

  redirect "/events/#{event.id}"
end


# ----------------------------DELETE EVENT
delete '/events/:event_id' do
  Event.find(params[:event_id]).destroy

  redirect "/users/#{current_user.id}"
end