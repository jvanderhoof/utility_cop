class AppEnvironmentResource < ActiveRecord::Base
  belongs_to :app_environment
  belongs_to :app_resource

  store_accessor :settings

  def app_name
    [
      self.app_environment.app.name,
      self.app_environment.environment.name
    ].join(' ').gsub(' ', '-').downcase

    #{}"#{self.app_environment.app.name} #{self.app_environment.environment.name}".gsub(' ','-').downcase
  end

  #def name
  #  [
  #    app_environment.app_name_environment,
  #    app_resource.resource.name
  #  ].join(' ')
  #end

  #def application_name
  #  self.name.gsub(' ', '-')
  #end

  def ami
    (ami_id.present?) ? ami_id : app_resource.ami
  end
end

=begin

module Heroku
  class App < AppEnvironmentResource
    include Heroku
    #validates :name, presences: true
    #validates :heroku_app_id, presences: true

    before_create :set_name
    after_create :find_or_create_heroku_app

    store_accessor :settings, :name, :heroku_app_id

    def set_name
      self.name = "#{self.app_environment.app.name}-#{self.app_environment.environment.name}"
    end

    def app_info(app_name)
      begin
        @app_info ||= heroku.app.info(app_name)
      rescue Excon::Errors::NotFound
        nil
      end
    end

    def exists?(app_name)
      app_info && app_info.has_key?('id')
    end

    def find_or_create_heroku_app
      app = if exists?(self.name)
        heroku.app.info(self.name)
      else
        heroku.app.create(name: self.name)
      end
      self.heroku_app_id = app['id']
    end
  end

  class Server < AppEnvironmentResource
    include Heroku
    attr_reader :app_env
    store_accessor :settings, :heroku_app_id, :resource_count, :name


    #validates :name, presences: true
    #validates :heroku_app_id, presences: true

    before_create :get_heroku_app
    after_save :update_server_count

    def get_heroku_app
      self.heroku_app_id = Heroku::App.create(ap)
    end

    def update_server_count
      Rails.logger.info '!!!!!!!!!!!!!! UPDATE SERVER COUNT !!!!!!!!!!!!!!'
    end


    def build(app, environment, count)



    end
  end

  class Worker < AppEnvironmentResource
    include Heroku

  end

  class PostgresDatabase < AppEnvironmentResource
    include Heroku

  end
end
=end
