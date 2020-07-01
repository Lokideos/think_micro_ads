# frozen_string_literal: true

module Ads
  module ErrorSerializer
    extend self

    def from_messages(error_messages, meta: {})
      { errors: build_errors(error_messages, meta) }.to_json
    end
    alias from_message from_messages

    private

    def build_errors(error_messages, meta)
      error_messages.map { |message| build_error(message, meta) }
    end

    def build_error(message, meta = {})
      error = { detail: message }
      error[:meta] = meta if meta.present?
      error
    end
  end
end
