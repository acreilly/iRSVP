class EventsController < ApplicationController
  include EventsHelper
  include UsersHelper
  def new
    @event = Event.new
  end

  def create
    curr_event = params[:event]
    curr_event[:event_start] = string_from_date_select_params(params[:event], :event_start).to_datetime
    curr_event[:event_finish] = string_from_date_select_params(params[:event], :event_finish).to_datetime
    @event = Event.create(curr_event)
    if any_event_errors?
      flash[:error] = @current_error
      flash[:title] = params[:title]
      flash[:event_start] = curr_event[:event_start]
      flash[:event_finish] = curr_event[:event_finish]
      flash[:description] = curr_event[:description]
      flash[:location] = curr_event[:location]
    redirect_to new_event_path # or :back
  else
    @event.user_id = session[:user_id]
    @event.save
    redirect_to event_path(@event)
  end
end

def show
  @event = Event.find(params[:id])
  @host = User.find(@event.user_id)
end

def edit
  @event = Event.find(params[:id])
end

def update
  @event = Event.find(params[:id])
  binding.pry
  params[:event][:event_start] = string_from_date_select_params(params[:event], :event_start).to_datetime
  params[:event][:event_finish] = string_from_date_select_params(params[:event], :event_finish).to_datetime
    @event.update_attributes( # going to need to change this to params[:event]
      title: params[:event][:title],
      event_start: params[:event][:event_start],
      event_finish: params[:event][:event_finish],
      location: params[:event][:location],
      latitude: params[:event][:latitude],
      longitude: params[:event][:longitude],
      description: params[:event][:description])
    redirect_to event_path(@event)
  end

  def destroy
    Event.find(params[:id]).destroy
    redirect_to main_path(current_user)
  end
end
