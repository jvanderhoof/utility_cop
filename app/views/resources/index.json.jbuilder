json.array!(@resources) do |resource|
  json.extract! resource, :id, :name, :cookbook_url, :language_id, :ami_id
  json.url resource_url(resource, format: :json)
end
