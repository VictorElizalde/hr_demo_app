class SessionsController < Devise::SessionsController
  def create
    candidate = Candidate.find_by_email(sign_in_params[:email])

    if candidate && candidate.valid_password?(sign_in_params[:password])
      @current_candidate = candidate
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end
end