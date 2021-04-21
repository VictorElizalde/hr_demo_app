class AdminsController < ApplicationController
  before_action :redirect_unless_admin

  def index
  end

  private
    def redirect_unless_admin
      if current_candidate.try(:role) != "admin"
        flash[:alert] = "Only admins can enter"
        redirect_to root_path
      end
    end
end
