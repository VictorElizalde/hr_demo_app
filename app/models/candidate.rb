class Candidate < ApplicationRecord
  acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  devise :omniauthable, omniauth_providers: %i[facebook]

  has_many :applications
  has_many :vacancies, :through => :applications

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |candidate|
      name_split = auth.info.name.split(" ")
      candidate.email = auth.info.email
      candidate.password = Devise.friendly_token[0, 20]
      candidate.name = name_split[0]   # assuming the candidate model has a name
      candidate.last_name = name_split[1]   # assuming the candidate model has a name
      # candidate.image = auth.info.image # assuming the candidate model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # candidate.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |candidate|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["info"]
        candidate.email = data["email"] if candidate.email.blank?
      end
    end
  end
end
