# ander
rspec setup made easy!

## Install

```
gem install ander
```

## Requirements

* Ruby 1.9.3 or higher

##**What it do**
  - Sets up rspec, rspec-rails and simplecov for your rails project

##**What it exactly do**
  1. Adds rspec, rspec-rails and simplecov to your Gemfile
  2. Executes bundle install
  3. Executes rails generate rspec:install
  4. Configures .rspec file to include html format output
  5. Configures spec_helper.rb file for simplecov and rspec-rails
  6. Adds sample_spec.rb file which shows how to write unit-tests with rspec

##**How to use**
  1. Add ander to your Gemfile
  2. Bundle install
  3. Run Ander.setup_all in your rails console

