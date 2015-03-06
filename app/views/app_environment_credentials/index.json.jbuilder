json.array!(@app_environment_credentials) do |app_environment_credential|
  json.extract! app_environment_credential, :id, :credential_id, :app_environment_id, :encrypted_value, :text_value
  json.url app_environment_credential_url(app_environment_credential, format: :json)
end
