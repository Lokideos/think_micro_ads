# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Ad do
  subject { Ad }

  describe '.page' do
    let(:records_per_page) { Ad::RECORDS_PER_PAGE }
    Fabricate.times(10, :ad)

    context 'page is provided' do
      let(:page) { 1 }

      it 'should return correct pages' do
        correct_pages = Ad.reverse_order(:updated_at).offset(page * records_per_page)
                          .limit(records_per_page).all

        expect(Ad.page(page: page)).to eq correct_pages
      end
    end

    context 'page is not provided' do
      context 'page is nil' do
        let(:page) { nil }

        it 'should return correct pages' do
          correct_pages = Ad.reverse_order(:updated_at).limit(records_per_page).all

          expect(Ad.page(page: page)).to eq correct_pages
        end
      end

      context 'page is zero' do
        let(:page) { 0 }

        it 'should return correct pages' do
          correct_pages = Ad.reverse_order(:updated_at).limit(records_per_page).all

          expect(Ad.page(page: page)).to eq correct_pages
        end
      end
      context 'page is negative number' do
        let(:page) { -1 }

        it 'should return correct pages' do
          correct_pages = Ad.reverse_order(:updated_at).limit(records_per_page).all

          expect(Ad.page(page: page)).to eq correct_pages
        end
      end
    end
  end

  describe '.total_pages' do
    Fabricate.times(10, :ad)

    it 'should return an integer' do
      expect(subject.total_pages).to be_a Integer
    end

    it 'should return correct number of pages' do
      expect(subject.total_pages).to eq Ad.count / Ad::RECORDS_PER_PAGE + 1
    end

    it 'should not return not correct number of pages' do
      expect(subject.total_pages).to_not eq Ad.count / Ad::RECORDS_PER_PAGE
    end
  end

  describe '.sanitized_params' do
    let(:correct_params) do
      {
        title: 'correct_title',
        description: 'correct_description',
        city: 'correct_city',
        user_id: '1'
      }
    end

    it 'should return a hash' do
      expect(Ad.sanitized_params(correct_params)).to be_a Hash
    end

    it 'should return hash with correct keys' do
      correct_keys = %i[title description city user_id]

      expect(Ad.sanitized_params(correct_params).keys).to eq correct_keys
    end

    context 'invalid attributes' do
      let(:excessive_params) do
        {
          title: 'correct_title',
          description: 'correct_description',
          city: 'correct_city',
          user_id: '1',
          bad_key: 'bad_value'
        }
      end

      it 'should not add not correct keys to the hash' do
        expect(Ad.sanitized_params(correct_params).keys).to_not include :bad_key
      end
    end
  end
end
