App.increment_notification = App.cable.subscriptions.create("IncrementNotificationChannel", {
  connected: function() {
  },

  disconnected: function() {
  },

  received: function(data) {
    /* Header notification badge and dropdown */
    $(".notification-friend-invitations#nfi" + data.requested_friend.id).css("display", "inline-block");
    $(".notification-friend-invitations#nfi" + data.requested_friend.id + " li").html(data.friend_requests_notification);
    $("#notification-dropdown" + data.requested_friend.id).append(data.notification_friend_invitation);

    /* Friend requests index */
    /* Headline */
    $(".friend-requests#fis" + data.requested_friend.id + " > .headline").html(data.headline_friend_invitations);
    /* Friend invitation item */
    $(".friend-requests#fis" + data.requested_friend.id).append(data.friend_invitation);
  }
});
