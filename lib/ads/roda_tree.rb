# frozen_string_literal: true

require_relative 'helpers/pagination_links'

module Ads
  class RodaTree < Roda
    include Ads::PaginationLinks
    plugin(:not_found) { { error: 'Not found' } }

    route do |r|
      r.root do
        '<h1>The RODA root</h1>'
      end

      r.on 'ads' do
        response['Content-Type'] = 'application/json'
        ads = Ad.page(page: request.params['page'].to_i - 1)
        serializer = AdSerializer.new(ads, links: pagination_links(Ad, request.path,
                                                                   request.params['page'].to_i))

        serializer.serialized_json
      end

      r.on 'favicon.ico' do
        'no_icon'
      end
    end
  end
end
