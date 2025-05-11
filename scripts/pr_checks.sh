#!/bin/bash
set -e

echo "🔄 Fetching latest changes from origin..."
git fetch origin

echo "🔍 Detecting changed Ruby files..."

# Try to find the merge base between origin/main and HEAD
merge_base=$(git merge-base origin/main HEAD || true)

if [[ -z "$merge_base" ]]; then
  echo "⚠️ No common ancestor found (probably a new branch). Checking all Ruby files instead..."
  changed_files=$(git ls-files '*.rb')
else
  changed_files=$(git diff --name-only "$merge_base"...HEAD -- '*.rb')
fi

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
