# frozen_string_literal: true

Sequel.migration do
  up do
    create_table :ads do
      primary_key :id
      String :title, null: false
      Text :description, null: false
      String :city, null: false
      Float :lat
      Float :lon
      String :user_id, null: false
      DateTime :created_at, null: false
      DateTime :updated_at, null: false
    end

    add_index :ads, :title, algorithm: :concurrent
  end

  down do
    drop_table(:ads)
  end
end
