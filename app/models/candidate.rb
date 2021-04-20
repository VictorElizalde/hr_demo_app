class Candidate < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_and_belongs_to_many :vacancies

  devise :omniauthable, :omniauth_providers => [:facebook]

  def self.from_omniauth(auth)
    name_split = auth.info.name.split(" ")
    candidate = Candidate.where(email: auth.info.email).first
    candidate ||= Candidate.create!(provider: auth.provider, uid: auth.uid, last_name: name_split[0], first_name: name_split[1], email: auth.info.email, password: Devise.friendly_token[0, 20])
      candidate
  end
end
