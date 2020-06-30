# frozen_string_literal: true

require 'roda'
require 'singleton'
require 'anyway_config'
require 'sequel'
require 'pry-byebug'

require_relative 'roda_tree'
require_relative 'config'

module Ads
  class Application
    include Singleton

    def bootstrap!
      @configuration = Ads::Config.new
      Ads::RodaTree.app
    end

    def call(env)
      Ads::RodaTree.call(env)
    end
  end
end
