FROM ubuntu:14.04

RUN apt-get update -qq && apt-get install -y build-essential curl libffi-dev

# for postgres
RUN apt-get install -y libpq-dev

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# for capybara-webkit
#RUN apt-get install -y libqt4-webkit libqt4-dev xvfb

# for a JS runtime
RUN apt-get install -y nodejs

RUN apt-get install -y libreadline-dev

ADD https://github.com/sstephenson/ruby-build/archive/v20150319zf.tar.gz /tmp/

RUN cd /tmp;                           \
    sudo chown default: *.tar.gz;      \
    tar xvzf *.tar.gz; rm -f *.tar.gz; \
    cd ruby-build*;                    \
    ./bin/ruby-build 2.2.0 /usr/local; \
    cd; rm -rf /tmp/ruby-build*

RUN gem install bundler pry --no-rdoc --no-ri

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
RUN bundle install

ADD . $APP_HOME
