require 'platform-api'

namespace :heroku do
  def conn
    @conn ||= PlatformAPI.connect_oauth(ENV['HEROKU_OAUTH'])
  end

  def heroku_app
    @app ||= heroku.app.info('test-project-testing')
  end

  def excon(path="")
    Excon.new("https://api.heroku.com/apps/test-project-testing/#{path}", headers: {
      'Accept' => 'application/vnd.heroku+json; version=3',
      'Authorization' => 'Bearer e823238d-2a1a-4393-aaf0-452b58bcc560'
      })
  end

  def xget
    excon.get
  end

  def xpost(path)
    excon(path).post
  end


  task :create, [:environment] do

    #curl -X GET https://api.heroku.com/apps/test-project-testing \
#-H "Accept: application/vnd.heroku+json; version=3" \
#-H "Authorization: Bearer $TUTORIAL_KEY"
    #puts Excon.get('https://api.heroku.com/apps/test-project-testing', headers: {
    #  'Accept' => 'application/vnd.heroku+json; version=3',
    #  'Authorization' => 'Bearer e823238d-2a1a-4393-aaf0-452b58bcc560'
    #  }).body
    puts xpost('sources').body

    #heroku = PlatformAPI.connect_oauth(ENV['HEROKU_OAUTH'])
    #puts heroku.app.list.to_yaml
    #puts heroku.addon.list('foxinsight-staging')
    #puts heroku.config_var.info('foxinsight-dev')
    #puts HerokuApp.find_or_create_by(app_environment_id: 1, app_resource_id: nil).info.inspect
  end
end

