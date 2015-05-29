class HerokuServer < AppEnvironmentResource
  include Heroku
  #attr_reader :app_env
  store_accessor :settings, :heroku_app_id, :resource_count#, :name


  #validates :name, presences: true
  #validates :heroku_app_id, presences: true

  before_create :get_heroku_app
  after_save :update_server_count

  def get_heroku_app
    self.heroku_app_id = Heroku::App.find_or_create_by(
                            app_environment_id: self.app_environment_id,
                            app_resource_id: nil
                          )
  end

  def update_server_count
    Rails.logger.info '!!!!!!!!!!!!!! UPDATE SERVER COUNT !!!!!!!!!!!!!!'
  end

end
