class Application < ApplicationRecord
  belongs_to :candidate
  belongs_to :vacancy

  has_one_attached :cv

  accepts_nested_attributes_for :candidate, reject_if: :all_blank, allow_destroy: true

  validates :bio, presence: true
end
