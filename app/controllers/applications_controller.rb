class ApplicationsController < ApplicationController
  def new
    @vacancy = Vacancy.find(params[:vacancy_id])
    @application = Application.new
  end

  def create
    @vacancy = Vacancy.find(params[:vacancy_id])
    @application = @vacancy.applications.new(application_params)
    @application.candidate = current_candidate

    if @application.save
      redirect_to list_vacancies_path, notice: 'Thank you for applying / we will contact you for next steps within 72 hours.'
    else
      flash[:alert] = 'Application not created.'
      render 'new'
    end
  end

  private
    def application_params
      params.require(:application).permit(:linked_in, :cv, :candidate_id, :vacancy_id)
    end
end
