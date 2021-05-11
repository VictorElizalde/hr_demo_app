module V1
  module CustomDevise
    class RegistrationsController < Devise::RegistrationsController
      respond_to :json

      acts_as_token_authentication_handler_for Candidate

      skip_before_action :authenticate_scope!
      append_before_action :authenticate_scope!, only: [:destroy]

      # POST /candidates
      def create
        build_resource(sign_up_params)

        if resource.save
          sign_up(resource_name, resource)
          render file: 'v1/custom_devise/registrations/create', status: :created
        else
          clean_up_passwords resource
          render file: "#{Rails.root}/public/422.json", status: :unprocessable_entity, locals: { errors: resource.errors.full_messages }
        end
      end

      # DELETE /candidates/id
      def destroy
        resource.deactivated_at = DateTime.now
        resource.save!
        Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
      end

      private

      def sign_up_params
        params.require(:candidate).permit([:password, :password_confirmation, :email])
      end
    end
  end
end
