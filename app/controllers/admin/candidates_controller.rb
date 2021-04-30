class Admin::CandidatesController < ApplicationController
  include CheckAdminConcern
  before_action :redirect_unless_admin

  def index
    @candidates = Candidate.where(role: 'candidate')
  end

  def show
    @candidate = Candidate.find(params[:id])
  end

  def edit
    @candidate = Candidate.find(params[:id])
  end

  def update
    @candidate = Candidate.find(params[:id])

    if @candidate.update(candidate_params)
      redirect_to admin_candidates_path, notice: 'Candidate updated successfully.'
    else
      flash[:alert] = 'Candidate not updated'
      render 'edit'
    end
  end

  def delete_candidate
    @candidate = Candidate.find(params[:id])
    @candidate.destroy
    redirect_to admin_candidates_path, notice: 'Candidate deleted successfully.'
  end

  private

  def candidate_params
    params.require(:candidate).permit(:name, :last_name, :email, :phone, :linkedin_id, :facebook_id, :address, :password, :password_confirmation)
  end
end
