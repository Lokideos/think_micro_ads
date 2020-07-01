# frozen_string_literal: true

namespace :db do
  desc 'Create test database'
  task :create_test do
    Sequel.connect(DB_CONFIGURATION.url) do |db|
      db.execute "CREATE DATABASE #{DB_CONFIGURATION.test_db_name}"
    end
  end
end
