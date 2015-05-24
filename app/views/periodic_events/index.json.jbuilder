json.array!(@periodic_events) do |periodic_event|
  json.extract! periodic_event, :id, :eventType, :start, :end, :periodicity, :user_id
  json.url periodic_event_url(periodic_event, format: :json)
end
