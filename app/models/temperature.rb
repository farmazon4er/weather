class Temperature < ApplicationRecord
  validates :temperature, :epoch_time, :current, presence: true

  scope :current, -> { where(current: true) }
  scope :historical, -> { where(current: false) }
end
