json.array!(@credentials) do |credential|
  json.extract! credential, :id, :key_name
  json.url credential_url(credential, format: :json)
end
