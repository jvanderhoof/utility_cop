json.array!(@app_resources) do |app_resource|
  json.extract! app_resource, :id, :app_id, :resource_id
  json.url app_resource_url(app_resource, format: :json)
end
