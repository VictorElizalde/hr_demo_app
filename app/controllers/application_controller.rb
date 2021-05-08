class ApplicationController < ActionController::Base
  acts_as_token_authentication_handler_for Candidate, fallback: :exception
  respond_to :json
end
