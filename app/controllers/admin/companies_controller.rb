class Admin::CompaniesController < ApplicationController
  include CheckAdminConcern
  before_action :authenticate_candidate!
  before_action :redirect_unless_admin

  def index
    companies = Company.all
    render json: companies
  end

  def show
    company = Company.find(params[:id])
  end

  def new
    company = Company.new
  end

  def edit
    company = Company.find(params[:id])
  end

  def create
    company = Company.new(company_params)
    if company.save
      render json: company
    else
      flash[:alert] = 'Company not created.'
      render 'new'
    end
  end

  def update
    company = Company.find(params[:id])

    if company.update(company_params)
      render json: company
    else
      flash[:alert] = 'Company not updated'
      render 'edit'
    end
  end

  def destroy
    company = Company.find(params[:id])
    company.destroy
    head :no_content, status: :ok
  end

  private

  def company_params
    params.require(:company).permit(:name, :contact_name, :contact_last_name, :contact_phone, :contact_email, :website)
  end
end
