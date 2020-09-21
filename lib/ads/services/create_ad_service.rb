# frozen_string_literal: true

module Ads
  class CreateAdService
    prepend BasicService

    option :ad do
      option :title
      option :description
      option :city
      option :user_id
    end

    attr_reader :ad

    def call
      @ad = ::Ad.new(@ad.to_h)
      @ad.validate
      return fail!(@ad.errors) if @ad.errors.any?

      GeocoderService.call
      @ad.save
    end
  end
end
