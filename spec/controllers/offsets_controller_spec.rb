require 'rails_helper'

RSpec.describe OffsetsController do
  before(:all) do
    Offset.create(value: 0.1)
  end

  describe 'PUT update' do
    context 'valid params' do
      let(:unsanitized_value) { 0.1231 }
      let(:sanitized_value) { unsanitized_value.to_f.round(1) }
      let(:positive_value) { 0.1 }
      let(:negative_value) { -0.1 }

      it 'should accept and sanitize decimal with longer precision' do
        put :update, params: { value: unsanitized_value }
        expect(response).to have_http_status(:accepted)
        expect(response.body).to include("Offset rate was set to #{sanitized_value}")
      end

      it 'should accept positive value within defined range' do
        put :update, params: { value: positive_value }
        expect(response).to have_http_status(:accepted)
        expect(response.body).to include("Offset rate was set to #{positive_value}")
      end

      it 'should accept negative value within defined range' do
        put :update, params: { value: negative_value }
        expect(response).to have_http_status(:accepted)
        expect(response.body).to include("Offset rate was set to #{negative_value}")
      end
    end

    context 'invalid params' do
      let(:out_of_range_value) { 0.3 }
      let(:non_numeric_value) { 'SEVENTY FIVE' }

      it 'should not accept value out of range' do
        put :update, params: { value: out_of_range_value }
        expect(response).to have_http_status(:bad_request)
      end

      it 'should not accept non-numeric value' do
        put :update, params: { value: non_numeric_value }
        expect(response).to have_http_status(:bad_request)
        expect(response.body).to include('Value is not a number')
      end

      it 'should not accept nil value' do
        put :update, params: { value: nil }
        expect(response).to have_http_status(:bad_request)
        expect(response.body).to include('Value is not a number')
      end
    end
  end
end
