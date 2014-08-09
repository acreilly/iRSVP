require 'spec_helper'

describe UsersController do
  describe "with no parameters" do
    it "has no users" do
      User.destroy_all
      user = User.all
      user.should have(0).users
    end
  end

  describe '#index' do
    let(:user) {FactoryGirl.create(:user)}
    it "should return @user vaiable that corresponds to a user" do
      get :index
      expect(assigns(:users)).to eq(User.all)
    end
  end

  describe '#mainpage' do
   let(:user) {FactoryGirl.create(:user)}
   it "should return @user vaiable that corresponds to a user" do
    get :mainpage, username: user.username
    expect(assigns(:user)).to eq(user)
  end
end

describe '#create' do
  let(:valid_params) {FactoryGirl.attributes_for(:user)}
  context 'when user puts in valid params' do
    it "should create a new user" do
      expect{
        post :create, user: valid_params}.to change{User.count}.by(1)
      end
      it 'redirected to users mainpage' do
        post :create, user: valid_params
        expect(response).to redirect_to(user_path(User.last))
      end
    end
    context 'when user puts in invalid params' do
      let(:invalid_params) { {first_name: "yo", birthday: Date.new(1991,03,03) }}
      it 'should not create a new user' do
        expect{
        post :create, user: invalid_params}.to change{User.count}.by(0)
      end
      it 'should redirect back to index page' do
        post :create, user: invalid_params
        expect(response).to redirect_to(root_path)
      end
      it 'should show flash errors'
    end
  end
end