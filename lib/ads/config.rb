# frozen_string_literal: true

require 'anyway_config'
require 'sequel/core'

module Ads
  class DbConfig < Anyway::Config
    config_name :db_config
    attr_config user: 'postgres', password: 'not_secure', host: '0.0.0.0', port: '5432'
    attr_config :url, :db_name

    def url
      @url ||= "postgres://#{user}:#{password}@#{host}:#{port}/#{db_name}"
    end

    def test_url
      @test_url ||= "postgres://#{user}:#{password}@#{host}:#{port}/#{test_db_name}"
    end

    def db_name
      @db_name ||= "ads_db_#{ENV['RACK_ENV']}"
    end

    def test_db_name
      @test_db_name ||= 'ads_db_test'
    end
  end
end
