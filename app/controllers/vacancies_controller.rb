class VacanciesController < ApplicationController
  def index
    @vacancies = Vacancy.all
  end

  def show
    @vacancy = Vacancy.find(params[:id])
  end

  def new
    @vacancy = Vacancy.new
  end

  def edit
    @vacancy = Vacancy.find(params[:id])
  end

  def create
    @vacancy = Vacancy.new(vacancy_params)
    if @vacancy.save
      redirect_to vacancies_path, notice: 'Vacancy created successfully.'
    else
      flash[:alert] = 'Vacancy not created.'
      render 'new'
    end
  end

  def update
    @vacancy = Vacancy.find(params[:id])

    if @vacancy.update(vacancy_params)
      redirect_to vacancies_path, notice: 'Vacancy updated successfully.'
    else
      flash[:alert] = 'Vacancy not updated'
      render 'edit'
    end
  end

  def destroy
    @vacancy = Vacancy.find(params[:id])
    @vacancy.destroy
    redirect_to vacancies_path, notice: 'Vacancy deleted successfully.'
  end

  private
    def vacancy_params
      params.require(:vacancy).permit(:title, :description, :min_salary, :max_salary, :published_at)
    end
end