# frozen_string_literal: true

namespace :db do
  desc 'Drop database'
  task :drop_test do
    Sequel.connect(DB_CONFIGURATION.url) do |db|
      db.execute "DROP DATABASE #{DB_CONFIGURATION.test_db_name}"
    end
  end
end
