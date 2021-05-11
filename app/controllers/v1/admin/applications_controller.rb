class Admin::ApplicationsController < ApplicationController
  include CheckAdminConcern
  before_action :authenticate_candidate!
  before_action :redirect_unless_admin, only: [:update, :index]

  def index
    @applications = Application.all.includes(:candidate, :vacancy)
  end

  def update
    @application = Application.find(params[:id])

    if @application.update(application_update_params)
      redirect_to admin_applications_path, notice: 'Application updated successfully.'
    else
      flash[:alert] = 'Application not updated'
      render 'index'
    end
  end

  private

  def application_update_params
    params.require(:application).permit(:status)
  end
end
