module EventsHelper
  def current_event_error
    @current_error ||= @event.errors.full_messages if @event.errors.full_messages.any?
  end

  def any_event_errors?
    current_event_error
  end

  def owners_event?
    Event.where(id: @event.id, user_id: current_user.id).any?
  end
end
