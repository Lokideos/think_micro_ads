# frozen_string_literal: true

require_relative 'helpers/pagination_links'
require_relative 'helpers/api_errors'

module Ads
  class RodaTree < Roda
    include Ads::PaginationLinks
    include Ads::ApiErrors
    plugin(:not_found) { { error: 'Not found' } }
    plugin(:json_parser)

    route do |r|
      r.root do
        '<h1>The RODA root</h1>'
      end

      r.on 'ads' do
        r.get do
          response['Content-Type'] = 'application/json'
          ads = Ad.page(page: request.params['page'].to_i - 1)
          serializer = AdSerializer.new(ads, links: pagination_links(Ad, request.path,
                                                                     request.params['page'].to_i))

          serializer.serialized_json
        end

        r.post do
          result = Ads::CreateAdService.call(ad: Ad.sanitized_params(request.params))

          if result.success?
            response['Content-Type'] = 'application/json'
            response.status = 201
            serializer = AdSerializer.new(result.ad)

            serializer.serialized_json
          else
            error_response(result.errors, 422).to_json
          end
        end
      end

      r.on 'favicon.ico' do
        'no_icon'
      end
    end
  end
end
