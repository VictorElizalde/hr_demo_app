class Vacancy < ApplicationRecord
  belongs_to :company
  has_many :applications
  has_many :candidates, :through => :applications
end
