class IncrementNotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'friend_request_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    ActionCable.server.broadcast 'friend_request_channel', content: data['render_friend_invitation(friend_request)'], requested_friend: data['@requested_friend'], friend_requestor: data['friend_request.friend_requestor'], friend_request: data['friend_request'], friend_requests_notification: data['friend_requests_notification'], current_user: data['current_user']
  end
end
