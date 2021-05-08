module CheckAdminConcern
  extend ActiveSupport::Concern

  included do
    helper_method :redirect_unless_admin
  end

  def redirect_unless_admin
    if current_candidate.try(:role) != "admin"
      render json: {"error_message": "Only admins can enter"}, status: :unprocessable_entity
    end
  end
end