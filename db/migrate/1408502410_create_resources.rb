Sequel.migration do
  change do
    execute 'create extension if not exists "uuid-ossp"'
    create_table(:resources) do
      uuid         :uuid, default: Sequel.function(:uuid_generate_v4), primary_key: true
      text         :heroku_id,    null: false
      text         :plan,         null: false
      text         :region,       null: false
      text         :callback_url, null: false
      timestamptz  :created_at,   default: Sequel.function(:now), null: false
      timestamptz  :updated_at
    end
  end
end
