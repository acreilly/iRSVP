class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @event = Event.create(params)
    if any_event_errors?
      flash[:error] = @current_error
      flash[:title] = params[:title]
      flash[:event_start] = params[:event_start]
      flash[:event_finish] = params[:event_finish]
      flash[:description] = params[:description]
      flash[:location] = params[:location]
    redirect_to new_event_path # or :back
  else
    params[:event_start].to_datetime
    params[:event_finish].to_datetime
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
  event = Event.find(params[:id])
    event.update_attributes( # going to need to change this to params[:event]
      title: params[:title],
      event_start: params[:event_start],
      event_finish: params[:event_finish],
      location: params[:location],
      latitude: params[:latitude],
      longitude: params[:longitude],
      description: params[:description])
  end

  def destroy
    Event.find(params[:id]).destroy
  end
end
