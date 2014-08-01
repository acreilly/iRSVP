require 'google/api_client'
API_KEY = 'AIzaSyDtzn8Cy4XSIX8sTNz0dzcq251Q2AcwtGg'
CLIENT_ID = '710528903507-764ad3ljutjbnbf9p55ls44t87nqr0dm.apps.googleusercontent.com'
CLIENT_SECRET = 'mFzp4_pRAozZHWP5a-BZtfHA'
REDIRECT_URI = 'http://localhost:9393/oauth2callback'

def logger; settings.logger end

def api_client; settings.api_client; end

def calendar_api; settings.calendar; end

def user_credentials
  @authorization ||= (
    auth = api_client.authorization.dup
    auth.redirect_uri = to('/oauth2callback')
    auth.update_token!(session)
    auth
  )
end

configure do
  log_file = File.open('calendar.log', 'a+')
  log_file.sync = true
  logger = Logger.new(log_file)
  logger.level = Logger::DEBUG

  client = Google::APIClient.new
  client.authorization.client_id = CLIENT_ID
  client.authorization.client_secret = CLIENT_SECRET
  client.authorization.scope = 'https://www.googleapis.com/auth/calendar'

  calendar = client.discovered_api('calendar', 'v3')

  set :logger, logger
  set :api_client, client
  set :calendar, calendar
end

before do
  # Ensure user has authorized the app
  unless user_credentials.access_token || request.path_info =~ /^\/oauth2/
    redirect to('/oauth2authorize')
  end
end

after do
  # Serialize the access/refresh token to the session
  session[:access_token] = user_credentials.access_token
  session[:refresh_token] = user_credentials.refresh_token
  session[:expires_in] = user_credentials.expires_in
  session[:issued_at] = user_credentials.issued_at
end
get '/oauth2authorize' do
  # Request authorization
  redirect user_credentials.authorization_uri.to_s, 303
end

get '/oauth2callback' do
  # Exchange token
  user_credentials.code = params[:code] if params[:code]
  user_credentials.fetch_access_token!
  require 'pry'; binding.pry
  redirect to('/')
end

get '/oauth' do
  # Fetch list of events on the user's default calandar
  result = api_client.execute(:api_method => settings.calendar.events.list,
                              :parameters => {'calendarId' => 'primary'},
                              :authorization => user_credentials)
  [result.status, {'Content-Type' => 'application/json'}, result.data.to_json]
end