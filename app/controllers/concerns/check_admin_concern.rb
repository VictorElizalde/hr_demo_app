module CheckAdminConcern
  extend ActiveSupport::Concern

  included do
    helper_method :redirect_unless_admin
  end

  def redirect_unless_admin
    if current_candidate.try(:role) != "admin"
      flash[:alert] = "Only admins can enter"
      redirect_to root_path
    end
  end
end