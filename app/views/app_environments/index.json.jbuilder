json.array!(@app_environments) do |app_environment|
  json.extract! app_environment, :id, :app_id, :environment_id, :git_tag
  json.url app_environment_url(app_environment, format: :json)
end
