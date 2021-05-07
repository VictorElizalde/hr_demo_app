class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  respond_to :json
  before_action :underscore_params!
  before_action :authenticate_candidate

  private
  def authenticate_candidate
    if request.headers['Authorization'].present?
      authenticate_or_request_with_http_token do |token|
        begin
          jwt_payload = JWT.decode(token, Rails.application.secrets.secret_key_base).first

          @current_candidate_id = jwt_payload['id']
        rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
          head :unauthorized
        end
      end
    end
  end

  def authenticate_candidate!(options = {})
    head :unauthorized unless signed_in?
  end

  def current_candidate
    @current_candidate ||= super || Candidate.find(@current_candidate_id)
  end

  def signed_in?
    @current_candidate_id.present?
  end
end
