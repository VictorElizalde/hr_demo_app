class Company < ApplicationRecord
  has_many :vacancies, :dependent => :destroy
end
