require 'rails_helper'

RSpec.describe UsersController do
  context '#DELETE' do
    let(:user) { User.create(email: 'delete_me@test.test') }
    let(:temperature) { Temperature.create(user: user, value: 37.5) }

    it 'should delete current user and associated Temperature records' do
      delete :destroy, params: { id: user.id }
      expect(response.status).to be 200
      expect(user.temperatures).to be_empty
    end
  end
end
