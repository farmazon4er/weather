class Temperature < ApplicationRecord
  validates :temperature, :epoch_time, presence: true

  scope :current, -> { where(current: true) }
  scope :historical, -> { where(current: false) }
end
