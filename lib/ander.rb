class Ander
	def self.setup_all
		self.add_to_gemfile
		self.bundle_install
		self.run_setup_commands
		self.configure_dotrspec
		self.modify_spec_helper
		self.add_sample_spec_file
	end

	def self.add_to_gemfile
		# Include rspec, rails_spec and simplecov in Gemfile
		puts "\n--Adding rspec, rspec-rails and simplecov to the Gemfile"
		# Check if any gems already exists in Gemfile
		rspec = false
		rspec_rails = false
		simplecov = false
		open('Gemfile', 'r') { |f|
			x = f.readlines
			x.each do |i|
				if i.include? "'rspec'"
					rspec = true
				end
				if i.include? "'rspec-rails'"
					rspec_rails = true
				end
				if i.include? "'simplecov'"
					simplecov = true
				end
			end
		}
		# add to Gemfile only for the missing gems
		unless rspec and rspec_rails and simplecov
			open('Gemfile', 'a') { |f|
				f.puts 'group :development, :test do'
				unless rspec
					puts '-Added rspec to Gemfile'
					f.puts "  gem 'rspec'"
				end
				unless rspec_rails
					puts '-Added rspec-rails to Gemfile'
					f.puts "  gem 'rspec-rails'"
				end
				unless simplecov
					puts 'Added simplecov to Gemfile'
					f.puts "  gem 'simplecov'"
				end
				f.puts 'end'
			}
		end

	end

	def self.bundle_install
		# Bundle install
    puts "\n--Executing Bundle Install"
		system('bundle install')
	end

	def self.run_setup_commands
		# run all required setup commands for rspec
		puts "\n--Running setup commands for rspec"
		system('spring stop')
		puts '-Executing rails generate rspec:install'
		system('rails generate rspec:install')
		system('spring stop')
	end

	def self.configure_dotrspec
		# configure .rspec
		puts "\n--configuring rspec output format in .rspec"
		puts '-setting output format to progress and html'
		open('.rspec', 'w') { |f|
			f.puts '--color'
			f.puts '--require spec_helper'
			f.puts '--format progress'
			f.puts '--format html'
			f.puts '--out spec/rspec_results.html'
		}
	end

	def self.modify_spec_helper
		puts "--Modifying spec_helper.rb"
		open('spec/spec_helper.rb', 'r'){ |f|
			simple_flag = false
			rspec_rails = false
			@contents = f.readlines
			@contents.each do |i|
				if i.include? "require 'simplecov'"
					simple_flag = true
				end
				if i.include? "require 'rspec/rails'"
					rspec_rails = true
				end
			end
			if simple_flag
				puts 'simplecov setting already exists in spec_helper.rb'
			else
				puts "-Adding require 'simplecov' to spec_helper.rb"
				@contents.each_with_index {|i, index|
					if i.include? "RSpec.configure do |config|\n"
						@contents[index] =
							i + "  require 'simplecov'\n"\
                  "  SimpleCov.start\n"
					end
				}
			end
			if rspec_rails
			puts 'rails environment setting already exists in spec_helper.rb'
			else rspec_rails
				puts "-Adding rails environment setting and require 'rspec/rails' to spec_helper.rb"
				@contents.each_with_index {|i, index|
					if i.include? "RSpec.configure do |config|\n"
						@contents[index] =
							i + "  ENV['RAILS_ENV'] = 'test'\n"\
									"  require File.expand_path('../../config/environment', __FILE__)\n"\
									"  require 'rspec/rails'\n"
					end
				}
			end
		}
		f = open('spec/spec_helper.rb', 'w')
		@contents.each do |i|
			f.write(i)
		end
		f.close
	end

	def self.add_sample_spec_file
		f = open('spec/sample_spec.rb', 'w')

		f.write	"require 'rails_helper'\n"

		f.write	 "RSpec.describe 'Target Object' do\n"

		f.write	 "  before(:all) do\n"
		f.write	 "  # 'This gets executed before all test cases in current script'\n"
		f.write	 "  end\n"

		f.write	 "  before(:each) do\n"
		f.write	 "  # 'This gets executed before each test cases in current script'\n"
		f.write	 "  end\n"

		f.write	 "  after(:all) do\n"
		f.write	 "  # 'This gets executed after all test cases in current script'\n"
		f.write	 "  end\n"

		f.write	 "  after(:each) do\n"
		f.write	 "  # 'This gets executed after each test cases in current script'\n"
		f.write	 "  end\n"

		f.write	 "  describe 'Title of test case:' do\n"
		f.write	 "    context 'Context of your test case' do\n"
		f.write	 "      let(:x) {\n"
		f.write	 "        x = 'This gets executed upon calling for x'\n"
		f.write	 "      }\n"
		f.write	 "      it 'Expected result of your test case' do\n"
		f.write	 "        expect(x).to eq('This gets executed upon calling for x')\n"
		f.write	 "      end\n"
		f.write	 "    end\n"
		f.write	 "  end\n"
		f.write	 "end\n"
		f.close
	end

end

