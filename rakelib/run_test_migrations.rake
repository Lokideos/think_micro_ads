# frozen_string_literal: true

namespace :db do
  desc 'Run migrations'
  task :migrate, [:version] do |_task, args|
    Sequel.extension :migration

    version = args[:version].to_i if args[:version]

    Sequel.connect(DB_CONFIGURATION.url) do |db|
      Sequel::Migrator.run(db, 'db/migrations', target: version)
    end
    Rake::Task['db:version'].execute
  end
end
