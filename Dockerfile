FROM ubuntu:14.04

RUN apt-get update -qq && apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libcurl4-openssl-dev libffi-dev curl

# for postgres
RUN apt-get install -y libpq-dev

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# for mysql
# RUN apt-get install -y libmysqlclient-dev

# for capybara-webkit
#RUN apt-get install -y libqt4-webkit libqt4-dev xvfb

# for a JS runtime
RUN apt-get install -y nodejs

RUN cd /tmp;                                                                \
      curl -O http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.1.tar.gz;    \
      sudo chown default: *.tar.gz;                                         \
      tar xvzf *.tar.gz; rm -f *.tar.gz;                                    \
      cd ruby*;                                                             \
      ./configure;                                                          \
      make;                                                                 \
      make install;                                                         \
      cd;                                                                   \
      rm -rf /tmp/ruby*

RUN gem install bundler pry rails --no-rdoc --no-ri

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install

ADD . $APP_HOME
