class V1::ApplicationsController < ApplicationController
  before_action :authenticate_candidate!
  
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

  private

  def application_params
    params.require(:application).permit(:personal_site, :cv, :bio, :candidate_id, :vacancy_id, :status,
      candidate_attributes: [:id, :name, :last_name, :address, :_destroy]
    )
  end
end
