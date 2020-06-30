require_relative "config/environment"

ENV['RACK_ENV'] = "development" unless ENV['RACK_ENV']
run Ads.application