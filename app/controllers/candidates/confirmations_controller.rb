class ConfirmationsController < Devise::ConfirmationsController
  respond_to :json

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    self.resource = Candidate.confirm_by_token(params[:confirmation_token])

    yield resource if block_given?

    if resource.errors.empty?
      render file: 'sessions/create', locals: { current_candidate: resource}
    else
      render file: "#{Rails.root}/public/422.json", status: :unprocessable_entity, locals: { errors: resource.errors.full_messages }
    end
  end
end