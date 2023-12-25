class Temperature < ApplicationRecord
  validates :temperature, :epoch_time, presence: true
end
