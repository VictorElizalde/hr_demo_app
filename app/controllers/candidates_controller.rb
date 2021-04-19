class CandidatesController < ApplicationController
  def index
    @candidates = Candidate.all
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
    if @candidate.save
      redirect_to candidates_path, notice: 'Candidate created successfully.'
    else
      flash[:alert] = 'Candidate not created.'
      render 'new'
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

  def destroy
    @candidate = Candidate.find(params[:id])
    @candidate.destroy
    redirect_to candidates_path, notice: 'Candidate deleted successfully.'
  end

  private
    def candidate_params
      params.require(:candidate).permit(:name, :last_name, :email, :phone, :linkedin_id, :facebook_id)
    end
end