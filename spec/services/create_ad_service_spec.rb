# frozen_string_literal: true

RSpec.describe Ads::CreateAdService do
  let(:geocoder_service_object) { double('Ads::GeocoderService') }

  before do
    allow(Ads::GeocoderService).to receive(:new).and_return(geocoder_service_object)
    allow(geocoder_service_object).to receive(:call)
  end

  context 'with valid params' do
    let(:correct_params) do
      {
        title: 'correct_title',
        description: 'correct_description',
        city: 'correct_city',
        user_id: '1'
      }
    end

    subject { Ads::CreateAdService.new(ad: correct_params) }

    it 'should create new Ad in the database' do
      expect { subject.call }.to change(Ad, :count).by(1)
    end

    it 'should return Ad service object' do
      expect(subject.call).to be_a Ads::CreateAdService
    end

    it 'should return Ad object with no errors' do
      expect(subject.call.errors).to be_empty
    end

    it 'should return Ad object in ad field' do
      expect(subject.call.ad).to be_a Ad
    end

    it 'should return Ad object with correct params' do
      ad_values = subject.call.ad.values

      correct_params.each do |key, value|
        expect(ad_values[key]).to eq value
      end
    end

    it 'should trigger geocoder service' do
      expect(geocoder_service_object).to receive(:call)

      subject.call
    end
  end

  context 'with non valid params' do
    let(:invalid_params) do
      {
        title: 'correct_title',
        description: nil,
        city: 'correct_city',
        user_id: '1'
      }
    end

    subject { Ads::CreateAdService.new(ad: invalid_params) }

    it 'should not create Ad' do
      expect { subject.call }.to_not change(Ad, :count)
    end

    it 'should return Ad service object' do
      expect(subject.call).to be_a Ads::CreateAdService
    end

    it 'should return Ad object with non empty errors array' do
      expect(subject.call.errors).to_not be_empty
    end

    it 'should return Ad object with correct errors' do
      expect(subject.call.errors).to include [:description, ['is not present']]
    end

    it 'should return Ad object in ad field' do
      expect(subject.call.ad).to be_a Ad
    end

    it 'should return Ad object with correct params' do
      ad_values = subject.call.ad.values

      invalid_params.each do |key, value|
        expect(ad_values[key]).to eq value
      end
    end

    it 'should not trigger geocoder service' do
      expect(geocoder_service_object).to_not receive(:call)

      subject.call
    end
  end
end
