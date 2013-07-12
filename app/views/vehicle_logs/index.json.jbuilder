json.array!(@vehicle_logs) do |vehicle_log|
  json.extract! vehicle_log, :plate, :timestamp
  json.url vehicle_log_url(vehicle_log, format: :json)
end
