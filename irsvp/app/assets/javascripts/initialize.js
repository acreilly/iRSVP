$(document).ready(function(){
  var userController = new UserController();
  userController.initialize();
var mapController = new MapController()
mapController.initialize()
  // if($("#map-canvas").length > 0){
  //   google.maps.event.addDomListener(window, 'load', initialize);
  // }
});