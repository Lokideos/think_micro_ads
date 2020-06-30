# frozen_string_literal: true

namespace :db do
  desc 'Drop database'
  task :drop do
    Sequel.connect(DB_CONFIGURATION.url) do |db|
      db.execute "DROP DATABASE #{DB_CONFIGURATION.db_name}"
    end
  end
end
