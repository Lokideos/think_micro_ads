# frozen_string_literal: true

module Ads
  module ApiErrors
    def error_response(error_messages, status)
      response['Content-Type'] = 'application/json'
      response.status = status

      Ads::ErrorSerializer.from_messages(error_messages)
    end
  end
end
