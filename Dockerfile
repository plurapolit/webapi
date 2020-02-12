FROM ruby:2.6.5

ARG RAILS_ENV

ENV RAILS_ENV ${RAILS_ENV}
ENV SECRET_KEY_BASE=foo
ENV RAILS_SERVE_STATIC_FILES=true

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - &&\
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - &&\
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update \
    && apt-get install -y locales \
    build-essential \
    postgresql-client \
    nodejs \
    yarn

# RUN addgroup -g 1000 -S app \
#  && adduser -u 1000 -S app -G app
# USER app

WORKDIR /app

# Install gems
ADD Gemfile* /app/
RUN gem install bundler \
 && bundle config --global frozen 1 \
 && bundle install -j4 --retry 3

# Install yarn packages
COPY package.json yarn.lock /app/
RUN yarn install

# Add the Rails app
ADD . /app

# Precompile assets
RUN bundle exec rake assets:precompile

# Set Rails env
ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_SERVE_STATIC_FILES true

WORKDIR /app

# Expose Puma port
EXPOSE 3000

# Save timestamp of image building
RUN date -u > BUILD_TIME

# Start up
CMD ["/app/docker/startup.sh"]