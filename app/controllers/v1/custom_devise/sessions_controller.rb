module V1
  module CustomDevise
    class SessionsController < Devise::SessionsController
      respond_to :json

      acts_as_token_authentication_handler_for Candidate, fallback_to_devise: false

      # POST /candidates/sign_in
      def create
        allow_params_authentication!
        self.resource = warden.authenticate!(auth_options)

        reset_token resource
        render file: 'v1/custom_devise/sessions/create'
      end

      # DELETE /candidates/sign_out
      def destroy
        warden.authenticate!
        reset_token current_candidate
      end

      private

      def sign_in_params
        params.fetch(:candidate).permit([:password, :email, :token])
      end

      def reset_token(resource)
        resource.authentication_token = nil
        resource.save!
      end
    end
  end
end
