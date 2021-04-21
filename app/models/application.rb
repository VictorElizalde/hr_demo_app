class Application < ApplicationRecord
  belongs_to :candidate
  belongs_to :vacancy

  has_one_attached :cv
end
