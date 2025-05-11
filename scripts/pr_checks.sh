#!/bin/bash
set -e

echo "🔍 Running RuboCop..."
bundle exec rubocop

echo "🧪 Running RSpec..."
bundle exec rspec

echo "🛡️ Running Brakeman..."
bundle exec brakeman -z

echo "✅ All PR checks passed!"
