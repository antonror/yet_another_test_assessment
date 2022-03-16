require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    let(:valid_email) { 'anton@test.test' }
    let(:invalid_email) { 'iam_not!an@mail' }

    it 'allows creation with valid email' do
      expect(User.create(email: valid_email)).to be_valid
    end

    it 'forbids creation with invalid email' do
      expect(User.create(email: invalid_email)).not_to be_valid
    end
  end
end
