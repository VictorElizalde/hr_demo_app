class CompaniesController < ApplicationController
  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
  end

  def new
    @company = Company.new
  end

  def edit
    @company = Company.find(params[:id])
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to companies_path, notice: 'Company created successfully.'
    else
      flash[:alert] = 'Company not created.'
      render 'new'
    end
  end

  def update
    @company = Company.find(params[:id])

    if @company.update(company_params)
      redirect_to companies_path, notice: 'Company updated successfully.'
    else
      flash[:alert] = 'Company not updated'
      render 'edit'
    end
  end

  def destroy
    @company = Company.find(params[:id])
    @company.destroy
    redirect_to companies_path, notice: 'Company deleted successfully.'
  end

  private
    def company_params
      params.require(:company).permit(:name, :contact_name, :contact_last_name, :contact_phone, :contact_email, website:)
    end
end
