# Setup
FROM ruby:2.6.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /plurapolit
WORKDIR /plurapolit

# bundler and gems
COPY Gemfile /plurapolit/Gemfile
COPY Gemfile.lock /plurapolit/Gemfile.lock
RUN gem install bundler && bundle install

# npm
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
# to confirm, that it was installed successfully
RUN apt-get install -y nodejs

# yarn
RUN npm install -g yarn
RUN yarn install --check-files

COPY . /plurapolit

# Add a script to be executed every time the container starts.
COPY docker/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Port
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]