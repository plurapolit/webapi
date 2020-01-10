#!/bin/sh
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

mkdir -p ./tmp/pids

./docker/migrate-db.sh
bundle exec puma -C config/puma.rb