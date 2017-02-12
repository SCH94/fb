module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include Devise::Controllers::Helpers
    identified_by :efbook_user

    def connect
      self.efbook_user = find_verified_user
    end

    protected

      def find_verified_user
        if user_signed_in?
          current_user
        else
          reject_unauthorized_connection
        end
      end
  end
end
