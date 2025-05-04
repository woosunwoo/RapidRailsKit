#!/usr/bin/env bash
set -o errexit

# Used by Render during build step
bundle install
bundle exec rake assets:precompile
bundle exec rake db:migrate
