module Heroku
  def heroku
    @heroku ||= PlatformAPI.connect_oauth(ENV['HEROKU_OAUTH'])
  end
end