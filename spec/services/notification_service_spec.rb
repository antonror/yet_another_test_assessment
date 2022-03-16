describe NotificationService do
  describe '#notfy_user?' do
    let(:offset) { Offset.create(value: 0.1)}
    let(:sick_user) { User.create(email: 'sick@test.test') }
    let(:healthy_user) { User.create(email: 'healthy@test.test') }
    let(:stable_user) { User.create(email: 'stable@test.test') }

    let(:sick_readings)     { [36.5, 36.6, 36.7, 36.8, 36.9] }
    let(:healthy_readings)  { [36.4, 36.5, 36.6, 36.7, 36.8] }
    let(:stable_readings)   { [36.9, 36.9, 36.9, 36.9, 36.9] }

    before do
      sick_readings.each do |value|
        Temperature.create(user: sick_user, value: value)
      end

      healthy_readings.each do |value|
        Temperature.create(user: healthy_user, value: value)
      end

      stable_readings.each do |value|
        Temperature.create(user: stable_user, value: value)
      end
    end

    context 'without stubs' do
      it 'returns true for sick user' do
        expect(described_class.new(sick_user).notify_user?).to be_truthy
      end

      it 'returns false for healthy user' do
        expect(described_class.new(healthy_user).notify_user?).to be_falsey
      end

      it 'returns false for stable user' do
        expect(described_class.new(stable_user).notify_user?).to be_falsey
      end
    end

    context 'with stubs' do
      it 'should return false for sick user with reduced PREDICTION_GAP' do
        stub_const('CelsiusConstants::PREDICTION_GAP', 0.1)
        expect(described_class.new(sick_user).notify_user?).to be_falsey
      end

      it 'should return true for healthy user with increased Offset' do
        Offset.sole.update(value: 0.2)
        expect(described_class.new(healthy_user).notify_user?).to be_truthy
      end

      it 'should return true for stable user when ascending sequence assertion is stubbed' do
        allow_any_instance_of(described_class)
          .to receive(:ascending_sequence?)
          .with([37.0, 37.0, 37.0, 37.0, 37.0])
          .and_return(true)
        expect(described_class.new(stable_user).notify_user?).to be_truthy
      end
    end
  end
end
