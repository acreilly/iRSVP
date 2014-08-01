require 'spec_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation

DatabaseCleaner.clean


 # context "root path" do
 #    let(:title) { "iRSVP" }
 #    let!(:user) { User.create :first_name => title, :last_name => "hey there", :category => Category.create(:name => "business") }
 #    it "renders the index view" do
 #      get '/'
 #      expect(last_response.body).to include(title)
 #    end

describe 'GET /users' do
  it "should display all users" do
    DatabaseCleaner.clean
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

describe 'GET /profiles/:user_id' do
  it "should display a users profile page" do
    User.create(first_name: "Yo", last_name: "Reilly", birthday: Date.new(1991, 03, 03), email: "blahzz@aol.com", username: "blah", password_hash: "blah")
     current_user = User.find_by_first_name("Allie")
      # require 'pry'; binding.pry
    get "/profiles/#{current_user.id}"
    expect(last_response.status).to eq(200)
  end
end

describe 'POST /users' do
    let(:valid_params) { {first_name: "Allie", last_name: "Reilly", birthday: Date.new(1991, 03, 03), email: "acreilly@aol.com", username: "acreilly", password_hash: "blah"} }
  it "should create a new user" do
    expect {
      post '/users', user: valid_params
    }.to change {User.count}.by(1)

    expect(last_response).to be_redirect
  end
end

# it "should flash errors if any"
# end

# it "should create a birthday event"
# end

