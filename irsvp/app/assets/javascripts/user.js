function UserController(){}

UserController.prototype = {
  initialize: function(){
    var self = this;
    $("#attendee_submit").on("click", self.attendeeSubmit);
    $("#follow_button").on("click", self.followSubmit);
  },
  attendeeSubmit: function(){
    event.preventDefault();
    var selectedIndex = $("#attendee_user")[0].selectedIndex;
    var value = $("option")[selectedIndex].value;
    var event_id = $("input[name='event_id']")[0].value;
    var ajaxRequest = $.ajax({
      type: "POST",
      url: "/attendees",
      data: {event_id: event_id, username: value}
    });
    ajaxRequest.done(this.attendeeResponse);
  },
  attendeeResponse: function(data){
    var attendee = $.parseJSON(data);
    var addedAttendee = attendee.username;
    $(".attendee_ul").append("<li>"+ addedAttendee + "</li>");
  },
  followSubmit: function(){
    event.preventDefault();
    var user_id = $("input[name='user_id']")[0].value;
    var ajaxRequest = $.ajax({
      type: "POST",
      url: "/followings",
      data: {user_id: user_id}
    });
    ajaxRequest.done(this.followResponse);
  },
  followResponse: function(){
    var follow = $.parseJSON(data);
    $("#follower").append("<li><a href='/profiles/" + follow.id + "'>" + follow.username + "</a></li>");
  }
}