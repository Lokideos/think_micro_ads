# frozen_string_literal: true

module Ads
  class RodaTree < Roda
    plugin(:not_found) { { error: 'Not found' } }

    route do |r|
      r.root do
        '<h1>The RODA root</h1>'
      end
    end
  end
end
