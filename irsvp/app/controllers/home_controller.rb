class HomeController < ApplicationController
  include UsersHelper

  def index
    @user = User.new
  end
end
