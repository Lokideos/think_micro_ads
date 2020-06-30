# frozen_string_literal: true

require 'sequel/core'

namespace :db do
  desc 'Rollback migration'
  task :rollback, [:version] do |_task, args|
    Sequel.extension :migration

    args.with_defaults(version: 0)

    Sequel.connect(DB_CONFIGURATION.url) do |db|
      Sequel::Migrator.run(db, 'db/migrations', target: args.version.to_i)
    end
    Rake::Task['db:version'].execute
  end
end
