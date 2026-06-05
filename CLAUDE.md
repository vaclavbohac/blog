# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

A personal blog built on **Rails 8.1** (Ruby 4.0.5), using PostgreSQL, Hotwire (Turbo + Stimulus), Propshaft, and importmap for JS. Currently a near-vanilla Rails app with a single scaffolded `Post` resource (`title`, `perex`, `body`). No root route is defined yet (`config/routes.rb`).

## Commands

```bash
bin/setup                 # Install deps, prepare DB, start server (use --skip-server to skip boot)
bin/dev                   # Run the app (Puma)
bin/rails db:prepare      # Create + migrate DB
bin/rails db:test:prepare # Reset the test database

bin/rails test                              # Run all tests (Minitest)
bin/rails test test/models/post_test.rb     # Single file
bin/rails test test/models/post_test.rb:7   # Single test by line number
bin/rails test:system                       # Capybara/Selenium system tests (not run by default `test`)

bin/rubocop               # Lint (rubocop-rails-omakase style)
bin/rubocop -a            # Autocorrect
bin/brakeman --no-pager   # Static security scan
bin/bundler-audit         # Audit gems for CVEs
bin/importmap audit       # Audit JS deps
```

CI (`.github/workflows/ci.yml`) runs, and PRs are expected to pass: brakeman, bundler-audit, importmap audit, rubocop, `bin/rails db:test:prepare test`, and system tests.

## Architecture notes

- **Solid stack on Postgres**: cache (`solid_cache`), background jobs (`solid_queue`), and Action Cable (`solid_cable`) are all database-backed — no Redis. Production uses **four separate Postgres databases** (primary, cache, queue, cable) configured in `config/database.yml`; each has its own `migrations_paths` (`db/cache_migrate`, `db/queue_migrate`, `db/cable_migrate`).
- **Deployment** is via **Kamal** (Docker) — see `config/deploy.yml` and `.kamal/`. The `Dockerfile` builds the production image; `bin/thrust` runs Thruster (HTTP caching/compression + X-Sendfile) in front of Puma.
- **Assets**: Propshaft (not Sprockets) + importmap-rails (`config/importmap.rb`) — no Node/bundler build step for JS.

## Conventions

- Ruby style is **rubocop-rails-omakase**; house overrides go in `.rubocop.yml`.
- Migrations live in `db/migrate/`; `db/schema.rb` is the source of truth and is checked in — regenerate it via migrations, never edit by hand.
