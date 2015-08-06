json.array!(@events) do |event|
  json.extract! event, :id, :user_id, :event_name, :event_description, :status, :start_date, :end_date
  json.url event_url(event, format: :json)
end
