class DeleteRequestChannel < ApplicationCable::Channel
  def subscribed
    stream_from "delete_sent_friend_request_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
