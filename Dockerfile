FROM ruby:2.3.1

RUN echo 'deb http://ftp.uk.debian.org/debian jessie-backports main' >> /etc/apt/sources.list

RUN apt-get update && apt-get install -qq -y libsndfile1-dev build-essential sqlite3 nodejs redis-tools libpq-dev libqt4-dev libqtwebkit-dev software-properties-common --fix-missing --no-install-recommends

RUN gem install bundler -v "1.13.5"

ENV APP_HOME /lightning_talks

RUN mkdir $APP_HOME
RUN mkdir /shared
RUN mkdir /shared/pids
WORKDIR $APP_HOME

ENV BUNDLE_GEMFILE=$APP_HOME/Gemfile \
  BUNDLE_JOBS=2 \
  BUNDLE_PATH=/bundle

COPY Gemfile Gemfile.lock ./

RUN bundle install --path /bundle

COPY . .

RUN bundle exec rake assets:precompile
