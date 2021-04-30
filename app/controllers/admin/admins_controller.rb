class Admin::AdminsController < ApplicationController
  include CheckAdminConcern
  before_action :redirect_unless_admin

  def index
  end
end
