json.extract! user_record, :id, :file, :created_at, :updated_at
json.url user_record_url(user_record, format: :json)