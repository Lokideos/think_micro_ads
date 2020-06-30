# frozen_string_literal: true

namespace :db do
  desc 'Prints current schema version'
  task :version do
    Sequel.extension :migration

    version = if Sequel.connect(DB_CONFIGURATION.url).tables.include?(:schema_info)
                Sequel.connect(DB_CONFIGURATION.url)[:schema_info].first[:version]
              end || 0

    puts "Schema Version: #{version}"
  end
end
