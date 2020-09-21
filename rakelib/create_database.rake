# frozen_string_literal: true

namespace :db do
  desc 'Create database'
  task :create do
    Sequel.connect(DB_CONFIGURATION.url) do |db|
      db.execute "CREATE DATABASE #{DB_CONFIGURATION.db_name}"
    end
  end
end
