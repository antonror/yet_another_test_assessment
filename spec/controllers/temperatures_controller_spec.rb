# controller actions trigger model validations directly
# added specs for index action

require 'rails_helper'

RSpec.describe TemperaturesController do
  before(:all) do
    user = User.create(email: 'test@test.test')
    11.times { Temperature.create(user: user, value: 36.6) }
  end

  context '#GET' do
    it 'should render first ten temperature readings for current user' do
      get :index, params: { user_id: User.sole.id }
      expect(JSON.parse(response.body).count).to eq 10
    end
  end
end
