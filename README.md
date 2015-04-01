# ander
rspec setup made easy for rails!

## Install

```
gem install ander
```

## Requirements

* Ruby 1.9.3 or higher

##**What ander do**
  - Sets up rspec, rspec-rails and simplecov for your rails project

##**What ander exactly do**
  1. Adds rspec, rspec-rails and simplecov to your Gemfile
  2. Executes bundle install
  3. Executes rails generate rspec:install
  4. Configures .rspec file to include html format output
  5. Configures spec_helper.rb file for simplecov and rspec-rails
  6. Adds sample_spec.rb file which shows how to write unit-tests with rspec

##**How to use ander**
  1. Add ander to your Gemfile
  2. Bundle install
  3. Run Ander.setup_all in your rails console

##**Content of included Sample file**

  ```
  require 'rails_helper'
  RSpec.describe 'Target Object' do
    before(:all) do
    # 'This gets executed before all test cases in current script'
    end
    before(:each) do
    # 'This gets executed before each test cases in current script'
    end
    after(:all) do
    # 'This gets executed after all test cases in current script'
    end
    after(:each) do
    # 'This gets executed after each test cases in current script'
    end
    describe 'Title of test case:' do
      context 'Context of your test case' do
        let(:x) {
          x = 'This gets executed upon calling for x'
        }
        it 'Expected result of your test case' do
          expect(x).to eq('This gets executed upon calling for x')
        end
      end
    end
  end
  ```