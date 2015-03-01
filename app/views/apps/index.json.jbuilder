json.array!(@apps) do |app|
  json.extract! app, :id, :name, :git_repo, :language_id
  json.url app_url(app, format: :json)
end
