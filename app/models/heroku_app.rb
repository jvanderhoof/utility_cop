class HerokuApp < AppEnvironmentResource
  include Heroku
  #validates :name, presences: true
  #validates :heroku_app_id, presences: true

  before_create :set_name
  after_create :find_or_create_heroku_app

  store_accessor :settings, :name, :heroku_app_id

  def set_name
    self.name = app_name
  end





  def app_info(app_name)
    begin
      @app_info ||= heroku.app.info(app_name)
    rescue Excon::Errors::NotFound
      nil
    end
  end

  def exists?(app_name)
    app_info(app_name) && app_info(app_name).has_key?('id')
  end

  def find_or_create_heroku_app
    app = if exists?(self.name)
      heroku.app.info(self.name)
    else
      heroku.app.create(name: self.name)
    end
    self.heroku_app_id = app['id']
  end

  def info
    heroku.app.info(self.name)
  end
end
