get '/' do #MAIN PAGE
  if logged_in?
    redirect "/users/#{current_user.username}"
  else
    erb :index
  end
end


get '/login' do
# CONSIDER SIGN IN AND SIGN UP TO BE ONE PAGE WITH
# javascript EVENT LISTENER ON THE BUTTON CLICKED
erb :login
end

get '/users/new' do

  erb :sign_up
end