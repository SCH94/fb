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
    $("#notification-dropdown" + data.requested_friend.id + " > #" + data.friend_request.id).remove();
    $(".notification-friend-invitations#nfi" + data.requested_friend.id + " li").html(data.friend_requests_notification);
    //
    /*
     * Sent friend requests index
     */
    $(".sent-friend-request#fr" + data.friend_request.id).remove(); // sent friend request item
   
    /* 
     * User show page action buttons area DISABLED (FLAW)
     */
    // $(".status-with-action#u" + data.requested_friend.id).html(data.content); // Change to "Add friend" button to requested friend in all instances regardless of the current user
    // $(".status-with-action#u" + data.friend_requestor.id).empty();            // Remove 'Confirm' and 'Delete' buttons from friend requestor user in all instances regardless of current user
    
    /* 
     * Friend requests index
     */
    $(".friend-requests#fis" + data.requested_friend.id + " > .headline").html(data.headline_friend_invitations); // respond friend requests  heading
    $(".friend-request#fi" + data.friend_request.id).remove(); // friend request item

  }
});
