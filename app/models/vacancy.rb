class Vacancy < ApplicationRecord
  belongs_to :company
  has_many :applications, :dependent => :destroy
  has_many :candidates, :through => :applications
end
