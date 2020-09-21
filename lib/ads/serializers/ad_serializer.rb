# frozen_string_literal: true

module Ads
  class AdSerializer
    include FastJsonapi::ObjectSerializer

    attributes :title,
               :description,
               :city,
               :lat,
               :lon
  end
end
