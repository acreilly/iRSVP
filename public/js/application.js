$(document).ready(function() {
  $("#attendee_submit").on("click", attendeeSubmit);
  $("#follow_button").on("click", followSubmit);
  if($("#map-canvas").length > 0){
    google.maps.event.addDomListener(window, 'load', initialize);
  }
  // create a new event for already set locations
});

var attendeeSubmit = function(event){
  event.preventDefault();
  var selectedIndex = $("#attendee_user")[0].selectedIndex;
  var value = $("option")[selectedIndex].value;
  var event_id = $("input[name='event_id']")[0].value;
  var ajaxRequest = $.ajax({
    type: "POST",
    url: "/attendees",
    data: {event_id: event_id, username: value}
  });
  ajaxRequest.done(attendeeResponse);
};

function attendeeResponse(data){
  var attendee = $.parseJSON(data);
  var addedAttendee = attendee.username;
  $(".attendee_ul").append("<li>"+ addedAttendee + "</li>");
}


var followSubmit = function(event){
  event.preventDefault();
  var user_id = $("input[name='user_id']")[0].value;
  var ajaxRequest = $.ajax({
    type: "POST",
    url: "/followings",
    data: {user_id: user_id}
  });
  ajaxRequest.done(followResponse);
}

function followResponse(data){
  var follow = $.parseJSON(data);
  $("#follower").append("<li><a href='/profiles/" + follow.id + "'>" + follow.username + "</a></li>");
}






function initialize() {

  var markers = [];
  var lat = parseFloat($(".latitude")[0].value);
  var lon = parseFloat($(".longitude")[0].value);

  if($(".latitude")[0].value === ""){
    var map = new google.maps.Map(document.getElementById('map-canvas'), {
      mapTypeId: google.maps.MapTypeId.ROADMAP
    });
    var defaultBounds = new google.maps.LatLngBounds(
      new google.maps.LatLng(-33.8902, 151.1759),
      new google.maps.LatLng(-33.8474, 151.2631));
    map.fitBounds(defaultBounds);

  } else {

    var mapOptions = {
      center: new google.maps.LatLng(lat, lon),
      zoom: 14,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    }

    var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);


    var marker = new google.maps.Marker({
      position: mapOptions.center,
      map: map
    });

    $("#pac-input").value = $(".location")[0].value;
  }


  // Create the search box and link it to the UI element.
  var input = /** @type {HTMLInputElement} */(
    document.getElementById('pac-input'));
  map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

  var searchBox = new google.maps.places.SearchBox(
    /** @type {HTMLInputElement} */(input));

  // [START region_getplaces]
  // Listen for the event fired when the user selects an item from the
  // pick list. Retrieve the matching places for that item.
  google.maps.event.addListener(searchBox, 'places_changed', function() {
    var places = searchBox.getPlaces();

    if (places.length == 0) {
      return;
    }
    for (var i = 0, marker; marker = markers[i]; i++) {
      marker.setMap(null);
    }

    // For each place, get the icon, place name, and location.
    markers = [];
    var bounds = new google.maps.LatLngBounds();
    for (var i = 0, place; place = places[i]; i++) {
      var image = {
        url: place.icon,
        size: new google.maps.Size(71, 71),
        origin: new google.maps.Point(0, 0),
        anchor: new google.maps.Point(17, 34),
        scaledSize: new google.maps.Size(25, 25)
      };

      // Create a marker for each place.
      var marker = new google.maps.Marker({
        map: map,
        icon: image,
        title: place.name,
        position: place.geometry.location
      });
      markers.push(marker);

      $(".location")[0].value = place.formatted_address;
      $("#pac-input").value = $(".location")[0].value;
      $(".latitude")[0].value = place.geometry.location.k
      $(".longitude")[0].value = place.geometry.location.B

      bounds.extend(place.geometry.location);
    }

    map.fitBounds(bounds);
  });
  // [END region_getplaces]

  // Bias the SearchBox results towards places that are within the bounds of the
  // current map's viewport.
  google.maps.event.addListener(map, 'bounds_changed', function() {
    var bounds = map.getBounds();
    searchBox.setBounds(bounds);
  });
}

//       (function() {
//        var po = document.createElement('script'); po.type = 'text/javascript'; po.async = true;
//        po.src = 'https://apis.google.com/js/client:plusone.js';
//        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(po, s);
//       debugger
//      })();
// function signinCallback(authResult) {
//   if (authResult['status']['signed_in']) {
//     debugger
//     // Update the app to reflect a signed in user
//     // Hide the sign-in button now that the user is authorized, for example:
//     document.getElementById('signinButton').setAttribute('style', 'display: none');
//   } else {
//     // Update the app to reflect a signed out user
//     // Possible error values:
//     //   "user_signed_out" - User is signed-out
//     //   "access_denied" - User denied access to your app
//     //   "immediate_failed" - Could not automatically log in the user
//     console.log('Sign-in state: ' + authResult['error']);
//     debugger
//   }
// }