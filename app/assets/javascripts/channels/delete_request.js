App.delete_request = App.cable.subscriptions.create("DeleteRequestChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel

    /*
     * Header notification badge and dropdown
     */
    $("#notification-dropdown > #" + data.friend_request.id).remove();
    $(".notification-friend-invitations#nfi" + data.requested_friend.id + " li").html(data.friend_requests_notification);
   
    /* 
     * User show page action buttons area
     */
    $(".status-with-action#u" + data.requested_friend.id).html(data.content); // Change to "Add friend" button to requested friend
    $(".status-with-action#u" + data.friend_requestor.id).empty();            // Remove 'Confirm' and 'Delete' buttons from current user
    
    /* 
     * Friend requests index
     */
    $(".friend-requests > .headline").html(data.headline_friend_request); // respond friend requests  heading
    $(".friend-request#fr" + data.friend_request.id).remove(); // friend request item
    // $(".sent-friend-request#" + data.friend_request.id).remove(); // sent friend request item

  }
});
