# Sending friend requests
class FriendRequestsController < ApplicationController
  before_action :authenticate_user!

  def index
    @friend_invitations = current_user.friend_invitations # FIXME update test
    @sent_friend_requests = current_user.sent_friend_requests # TODO to test
  end

  def create
    friend_request = current_user.sent_friend_requests.build(friend_requests_params)
    @requested_friend = User.find(friend_requests_params[:requested_friend_id])

    respond_to do |format|
      format.js do
        if friend_request.save
          ActionCable.server.broadcast 'friend_request_channel', content: render_friend_invitation(friend_request), requested_friend: @requested_friend, friend_requestor: friend_request.friend_requestor, friend_request: friend_request, confirm_delete_buttons: render_confirm_delete_buttons(friend_request), friend_requests_notification: friend_requests_notification(@requested_friend), requested_friend_invitations_count: @requested_friend.friend_invitations.count, gender: helpers.gender_english(friend_request.friend_requestor), current_user: current_user
        end
      end
      format.html do
        if friend_request.save
          if request.referrer == users_url
            redirect_back fallback_location: root_path, notice: "Friend request sent to #{helpers.link_to helpers.facebooker(@user), user_path(@user)}", flash: { html_safe: true }
          elsif request.referrer == user_url(@user)
            redirect_back fallback_location: root_path, notice: 'Friend request sent.'
          end
        else
          redirect_to @user, alert: friend_request.errors.full_messages.first[:message]
        end
      end
    end
  end

  def destroy
    if @friend_request = FriendRequest.find_by(id: params[:id])
      @requested_friend = @friend_request.requested_friend
      friend_requestor = @friend_request.friend_requestor

      respond_to do |format|
        format.js do
          if @friend_request.destroy
            ActionCable.server.broadcast 'delete_friend_request_channel', content: render_add_friend_button(@requested_friend), friend_request: @friend_request, requested_friend: @requested_friend, friend_requestor: friend_requestor, friend_requests_notification: friend_requests_notification(@requested_friend), headline_friend_request: headline_friend_request
          end 
        end
        format.html do
          if @friend_request.friend_requestor != current_user
            @friend_request.destroy
            redirect_to user_friend_requests_path(current_user), notice: "Deleted received friend request by #{helpers.link_to helpers.friend_requestor_name(@friend_request), @friend_request.friend_requestor}", flash: { html_safe: true }
          else
            @friend_request.destroy
            redirect_to user_friend_requests_path(current_user), notice: "Deleted friend request sent to #{helpers.link_to helpers.requested_friend_name(@friend_request), @friend_request.requested_friend}", flash: { html_safe: true }
          end
        end
      end
    else
      render js: "alert('You have already deleted this friend request.');"
    end
  end

  private

    def friend_requests_params
      params.permit(:requested_friend_id)
    end

    def renderer
      @renderer ||= FriendRequestsController.renderer.new

      if @renderer.instance_variable_get(:@env).has_key? :warden
        @renderer
      else
        warden = env["warden"]
        @renderer.instance_variable_set(:@env, {"HTTP_HOST"   => "localhost:3000",
                                             "HTTPS"          => "off",
                                             "REQUEST_METHOD" => "GET",
                                             "SCRIPT_NAME"    => "",
                                             "warden"         => warden})
        @renderer
      end
    end

    def render_friend_invitation(friend_invitation)
      render partial: 'friend_requests/notification_friend_invitation', locals: { friend_invitation: friend_invitation }
    end

    def render_add_friend_button(user)
      render partial: 'users/user_add_friend', locals: { user: user }
    end

    def render_confirm_delete_buttons(friend_request)
      renderer.render partial: 'users/confirm_delete_buttons', locals: { friend_request: friend_request }
    end

    def headline_friend_request
      "Respond to your #{helpers.pluralize(@requested_friend.friend_invitations.count, 'Friend Request')}"
    end

    def friend_requests_notification(user)
      renderer.render partial: 'friend_requests/notification_friend_invitations', locals: { user: user }
    end
end
