json.array!(@app_environment_resources) do |app_environment_resource|
  json.extract! app_environment_resource, :id, :app_environment_id, :app_resource_id, :count, :ami_id
  json.url app_environment_resource_url(app_environment_resource, format: :json)
end
