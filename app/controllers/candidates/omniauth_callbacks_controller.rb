class Candidates::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: :facebook

  def facebook
    # You need to implement the method below in your model (e.g. app/models/candidate.rb)
    @candidate = Candidate.from_omniauth(request.env["omniauth.auth"])

    if @candidate.persisted?
      sign_in_and_redirect @candidate, event: :authentication # this will throw if @candidate is not activated
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"].except(:extra) # Removing extra as it can overflow some session stores
      redirect_to new_candidate_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end