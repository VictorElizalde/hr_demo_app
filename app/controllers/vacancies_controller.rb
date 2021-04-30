class VacanciesController < ApplicationController
  include CheckAdminConcern

  def list_vacancies
    @vacancies = Vacancy.all.includes(:company)
  end

  def see_vacancy
    @vacancy = Vacancy.find(params[:id])
  end
end
