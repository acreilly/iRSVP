require 'spec_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

DatabaseCleaner.clean

describe "with no parameters" do
  it "should have no events" do
    event = Event.all
    event.should have(0).events
  end
end

describe 'GET /events/new' do
  it "should show create an event page" do
    get '/events/new'
    expect(last_response.status).to eq(200)
  end
end

# describe 'GET /events/:event_id' do
#   it "should show the single event page" do
#      user = User.create(first_name: "Allie", last_name: "Reilly", birthday: "1991-03-03", email: "blah@aol.com", username: "blah")
#     event = Event.create(title: "Title", event_start: Date.today, user_id: user.id)
#     require 'pry'; binding.pry
#     get "/events/#{event.id}"
#     expect(last_response.status).to eq(200)
#   end
# end

describe 'POST /events'
it "should create new event"

end
end
# it "should not create new event"
# end
# end

# describe 'PUT /events/:event_id'
# it "should update an event"

# end
# end

# describe 'DELETE /events/:event_id'
# it "should delete an event"

# end
# end