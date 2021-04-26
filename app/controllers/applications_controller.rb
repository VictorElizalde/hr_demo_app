class ApplicationsController < ApplicationController
  include CheckAdminConcern
  before_action :redirect_unless_admin, only: [:update, :index]

  def index
    @applications = Application.all.includes(:candidate, :vacancy)
  end

  def new
    @vacancy = Vacancy.find(params[:vacancy_id])
    @application = Application.new
    @candidate = current_candidate
  end

  def create
    @vacancy = Vacancy.find(params[:vacancy_id])
    @application = @vacancy.applications.new(application_params)
    @application.candidate = current_candidate
    @candidate = current_candidate

    if @application.save
      redirect_to list_vacancies_path, notice: 'Thank you for applying / we will contact you for next steps within 72 hours.'
    else
      flash[:alert] = 'Application not created.'
      render 'new'
    end
  end

  def update
    @application = Application.find(params[:id])

    if @application.update(application_update_params)
      redirect_to applications_path, notice: 'Application updated successfully.'
    else
      flash[:alert] = 'Application not updated'
      render 'index'
    end
  end

  private

  def application_params
    params.require(:application).permit(:personal_site, :cv, :bio, :candidate_id, :vacancy_id, :status,
      candidate_attributes: [:id, :name, :last_name, :address, :_destroy]
    )
  end

  def application_update_params
    params.require(:application).permit(:status)
  end
end
