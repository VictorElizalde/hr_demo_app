class Admin::VacanciesController < ApplicationController
  include CheckAdminConcern
  before_action :authenticate_candidate!
  before_action :redirect_unless_admin

  def index
    vacancies = Vacancy.all.includes(:company)
    render json: vacancies
  end

  def show
    vacancy = Vacancy.find(params[:id])
  end

  def new
    vacancy = Vacancy.new
    companies = Company.all
  end

  def edit
    vacancy = Vacancy.find(params[:id])
    companies = Company.all
  end

  def create
    vacancy = Vacancy.new(vacancy_params)
    companies = Company.all

    if vacancy.save
      redirect_to admin_vacancies_path, notice: 'Vacancy created successfully.'
    else
      flash[:alert] = 'Vacancy not created.'
      render 'new'
    end
  end

  def update
    vacancy = Vacancy.find(params[:id])
    companies = Company.all

    if vacancy.update(vacancy_params)
      redirect_to admin_vacancies_path, notice: 'Vacancy updated successfully.'
    else
      flash[:alert] = 'Vacancy not updated'
      render 'edit'
    end
  end

  def destroy
    vacancy = Vacancy.find(params[:id])
    vacancy.destroy
    redirect_to admin_vacancies_path, notice: 'Vacancy deleted successfully.'
  end

  private

  def vacancy_params
    params.require(:vacancy).permit(:title, :description, :min_salary, :max_salary, :published_at, :company_id)
  end
end
