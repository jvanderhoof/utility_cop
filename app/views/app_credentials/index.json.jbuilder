json.array!(@app_credentials) do |app_credential|
  json.extract! app_credential, :id, :credential_id, :app_id, :encrypted_value, :text_value
  json.url app_credential_url(app_credential, format: :json)
end
