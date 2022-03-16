require 'rails_helper'

RSpec.describe Temperature, type: :model do
  context 'validations' do
    let(:user) { User.create(email: 'anton@test.test') }

    it 'should accept valid decimal within defined range' do
      expect(Temperature.create(user: user, value: 36.6)).to be_valid
    end

    it 'should not accept valid decimal outside of defined range' do
      expect(Temperature.create(user: user, value: 99.9)).not_to be_valid
    end

    it 'should not accept nil values' do
      expect(Temperature.create(user: user, value: nil)).not_to be_valid
    end

    it 'should not accept non-numeric values' do
      expect(Temperature.create(user: user, value: 'FIFTY SIX')).not_to be_valid
    end
  end
end
