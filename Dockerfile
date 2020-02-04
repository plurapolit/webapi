######################
# Stage: Builder
FROM ruby:2.6.5-alpine as Builder

ARG RAILS_ENV

ENV RAILS_ENV ${RAILS_ENV}
ENV SECRET_KEY_BASE=foo
ENV RAILS_SERVE_STATIC_FILES=true

RUN apk add --update --no-cache \
    build-base \
    postgresql-dev \
    git \
    nodejs \
    yarn \
    tzdata

WORKDIR /app

# Install gems
ADD Gemfile* /app/
RUN gem install bundler \
    && bundle install -j4 --retry 3

# Install yarn packages
COPY package.json yarn.lock /app/
RUN yarn install

# Add the Rails app
ADD . /app

# Precompile assets
RUN bundle exec rake assets:precompile

# Remove folders not needed in resulting image

###############################
# Stage Final
FROM ruby:2.6.5-alpine

ARG ADDITIONAL_PACKAGES

# Add Alpine packages
RUN apk add --update --no-cache \
    postgresql-client \
    $ADDITIONAL_PACKAGES \
    tzdata \
    file

# Add user
RUN addgroup -g 1000 -S app \
 && adduser -u 1000 -S app -G app
USER app

# Copy app with gems from former build stage
COPY --from=Builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=Builder --chown=app:app /app /app

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