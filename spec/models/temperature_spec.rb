require 'spec_helper'

RSpec.describe Temperature, type: :model do
  context 'validations' do
    it { should validate_presence_of(:temperature) }
    it { should validate_presence_of(:epoch_time) }
  end
end