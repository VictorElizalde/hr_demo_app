class Admin::AdministratorsController < ApplicationController
  include CheckAdminConcern
  before_action :redirect_unless_admin

  def index
    @administrators = Candidate.where(role: 'admin')
  end

  def show
    @administrator = Candidate.find(params[:id])
  end

  def new
    @administrator = Candidate.new
  end

  def edit
    @administrator = Candidate.find(params[:id])
  end

  def create
    @administrator = Candidate.new(administrator_params)
    @administrator.role = 'admin'

    respond_to do |format|
      if @administrator.save
        format.html { redirect_to admin_administrators_path, notice: 'Admin was successfully created.' }
        format.json { render json: @administrator, status: :created, location: [:admin, @administrator] }
      else
        format.html { render action: 'new' }
        format.json { render json: @administrator.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @administrator = Candidate.find(params[:id])

    if @administrator.update(administrator_params)
      redirect_to admin_administrators_path, notice: 'Administrator updated successfully.'
    else
      flash[:alert] = 'Administrator not updated'
      render 'edit'
    end
  end

  def delete_administrator
    @administrator = Candidate.find(params[:id])
    @administrator.destroy
    redirect_to admin_administrators_path, notice: 'Administrator deleted successfully.'
  end

  private

  def administrator_params
    params.require(:candidate).permit(:name, :last_name, :email, :phone, :linkedin_id, :facebook_id, :address, :password, :password_confirmation)
  end
end
