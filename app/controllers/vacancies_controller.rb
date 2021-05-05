class VacanciesController < ApplicationController
  include CheckAdminConcern

  def list_vacancies
    vacancies = Vacancy.all.includes(:company)
    render json: vacancies, status: :ok
  end

  def see_vacancy
    vacancy = Vacancy.find(params[:id])
    render json: vacancy, status: :ok
  end
end
