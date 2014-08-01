require 'spec_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

DatabaseCleaner.clean

describe "with no parameters" do
  it "has no users" do
    User.destroy_all
    user = User.all
    user.should have(0).users
  end
end

describe 'GET /users' do
  it "should display all users" do
    User.create(first_name: "Allie", last_name: "Reilly", birthday: "1991-03-03", email: "blah@aol.com", username: "blah")
    get '/users'
    expect(last_response.status).to eq(200)
  end
end

describe 'GET /users/:user_id' do
  it "should display the signed in users home page" do
    User.create(first_name: "Allie", last_name: "Reilly", birthday: "1991-03-03", email: "blah@aol.com", username: "blah")
    @user = User.find_by_first_name("Allie")

    get "/users/#{@user.id}"
    expect(last_response.status).to eq(200)
  end
end

# describe 'GET /profiles/:user_id' do
#   it "should display a users profile page" do
#     User.destroy_all
#     User.create(first_name: "Yo", last_name: "Reilly", birthday: Date.new(1991, 03, 03), email: "blahzz@aol.com", username: "blah", password_hash: "blah")
#     current_user = User.find_by_first_name("Yo")
#     browser = Rack::Test::Session.new(id: 1)
#     require 'pry'; binding.pry

#     get "/profiles/#{current_user.id}"
#     expect(last_response.status).to eq(200)
#   end
# end

describe 'POST /users' do
  it "should create a new user" do
    User.destroy_all
    valid_params = {first_name: "Hey", last_name: "Reilly", birthday: Date.new(1991, 03, 03), email: "acreilly@aol.com", username: "acreilly", password_hash: "blah"}
    count = User.count
    post '/users', valid_params
    # expect(last_response.status).to eq(201)
    expect(User.all.count).to eq(count + 1)
  end
end

# it "should flash errors if any"
# end

# it "should create a birthday event"
# end

