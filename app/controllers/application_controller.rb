class ApplicationController < ActionController::Base
  before_action :authenticate_candidate!
end
