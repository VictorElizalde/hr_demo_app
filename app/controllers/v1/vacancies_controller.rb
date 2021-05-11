class V1::VacanciesController < ApplicationController
  include CheckAdminConcern
  acts_as_token_authentication_handler_for Candidate

  def list_vacancies
    @vacancies = Vacancy.all.includes(:company)
  end

  def see_vacancy
    @vacancy = Vacancy.find(params[:id])
  end
end
