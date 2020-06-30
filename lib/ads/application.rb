# frozen_string_literal: true

require 'roda'
require 'singleton'
require 'anyway_config'
require 'sequel'
require 'pry-byebug'
require 'fast_jsonapi'

require_relative 'roda_tree'
require_relative 'config'
require_relative 'serializers/ad_serializer'

module Ads
  class Application
    include Singleton

    def bootstrap!
      setup_database
      Ads::RodaTree.app
    end

    def call(env)
      Ads::RodaTree.call(env)
    end

    def setup_database
      @db_configuration = Ads::DbConfig.new
      @db = Sequel.connect(@db_configuration.url)
      Sequel::Model.plugin :timestamps
      require_relative 'models/base_model'
    end
  end
end
