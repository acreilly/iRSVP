# require 'google/api_client'
# API_KEY = AIzaSyDtzn8Cy4XSIX8sTNz0dzcq251Q2AcwtGg
# CLIENT_ID = 710528903507-764ad3ljutjbnbf9p55ls44t87nqr0dm.apps.googleusercontent.com
# CLIENT_SECRET = mFzp4_pRAozZHWP5a-BZtfHA
# REDIRECT_URI = http://localhost:9393/oauth2callback



# def logger; settings.logger end

# def api_client; settings.api_client; end

# def calendar_api; settings.calendar; end

# def user_credentials
#   @authorization ||= (
#     auth = api_client.authorization.dup
#     auth.redirect_uri = to('/oauth2callback')
#     auth.update_token!(session)
#     auth
#   )
# end

# configure do
#   log_file = File.open('calendar.log', 'a+')
#   log_file.sync = true
#   logger = Logger.new(log_file)
#   logger.level = Logger::DEBUG

#   client = Google::APIClient.new
#   client.authorization.client_id = '710528903507-764ad3ljutjbnbf9p55ls44t87nqr0dm.apps.googleusercontent.com'
#   client.authorization.client_secret = 'mFzp4_pRAozZHWP5a-BZtfHA'
#   client.authorization.scope = 'https://www.googleapis.com/auth/calendar'

#   calendar = client.discovered_api('calendar', 'v3')

#   set :logger, logger
#   set :api_client, client
#   set :calendar, calendar
# end

# before do
#   # Ensure user has authorized the app
#   unless user_credentials.access_token || request.path_info =~ /^\/oauth2/
#     redirect to('/oauth2authorize')
#   end
# end

# after do
#   # Serialize the access/refresh token to the session
#   session[:access_token] = user_credentials.access_token
#   session[:refresh_token] = user_credentials.refresh_token
#   session[:expires_in] = user_credentials.expires_in
#   session[:issued_at] = user_credentials.issued_at
# end