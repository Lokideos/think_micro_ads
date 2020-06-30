# frozen_string_literal: true

require 'pathname'
require_relative 'ads/application'

module Ads
  class << self
    def application
      Application.instance
    end

    def root
      Pathname.new(File.expand_path('..', __dir__))
    end
  end
end
