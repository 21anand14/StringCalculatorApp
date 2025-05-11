#!/bin/bash
set -e

echo "🔍 Detecting changed Ruby files..."
changed_files=$(git diff --name-only origin/main...HEAD -- '*.rb')

if [[ -n "$changed_files" ]]; then
  echo "🔍 Running RuboCop on: $changed_files"
  bundle exec rubocop $changed_files
else
  echo "✅ No Ruby files changed. Skipping RuboCop."
fi

echo "🧪 Running RSpec..."
bundle exec rspec

echo "🛡️ Running Brakeman..."
bundle exec brakeman -z

echo "✅ All checks passed!"
