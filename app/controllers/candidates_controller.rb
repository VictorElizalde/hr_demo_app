class CandidatesController < ApplicationController
  before_action :redirect_unless_admin

  def index
    @candidates = Candidate.where(role: 'candidate')
  end

  def index_admins
    @candidates = Candidate.where(role: 'admin')
  end

  def show
    @candidate = Candidate.find(params[:id])
  end

  def new
    @candidate = Candidate.new
  end

  def edit
    @candidate = Candidate.find(params[:id])
  end

  def create
    @candidate = Candidate.new(candidate_params)
    @candidate.role = 'admin'

    respond_to do |format|
      if @candidate.save
        format.html { redirect_to admins_path, notice: 'Admin was successfully created.' }
        format.json { render json: @candidate, status: :created, location: [:admin,@candidate] }
      else
        format.html { render action: "new" }
        format.json { render json: @candidate.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @candidate = Candidate.find(params[:id])

    if @candidate.update(candidate_params)
      redirect_to candidates_path, notice: 'Candidate updated successfully.'
    else
      flash[:alert] = 'Candidate not updated'
      render 'edit'
    end
  end

  def delete_candidate
    @candidate = Candidate.find(params[:id])
    @candidate.destroy
    redirect_to candidates_path, notice: 'Candidate deleted successfully.'
  end

  private
    def candidate_params
      params.require(:candidate).permit(:name, :last_name, :email, :phone, :linkedin_id, :facebook_id, :address, :password, :password_confirmation)
    end

    def redirect_unless_admin
      if current_candidate.try(:role) != "admin"
        flash[:alert] = "Only admins can enter"
        redirect_to root_path
      end
    end
end
