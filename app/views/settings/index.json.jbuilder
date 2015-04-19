json.array!(@settings) do |setting|
  json.extract! setting, :id, :key, :value, :app_id
  json.url setting_url(setting, format: :json)
end
