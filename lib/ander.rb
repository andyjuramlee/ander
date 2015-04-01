class Ander
	def self.setup_all
		self.add_to_gemfile
		self.bundle_install
		self.run_setup_commands
		self.configure_dotrspec
		self.modify_spec_helper
	end

	def self.add_to_gemfile
		# Include rspec, rails_spec and simplecov in Gemfile
		puts "\nAdding rspec, rspec-rails and simplecov to the Gemfile"
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
					f.puts "  gem 'rspec'"
				end
				unless rspec_rails
					f.puts "  gem 'rspec-rails'"
				end
				unless simplecov
					f.puts "  gem 'simplecov'"
				end
				f.puts 'end'
			}
		end

	end

	def self.bundle_install
		# Bundle install
    puts "\nExecuting Bundle Install"
		system('bundle install')
	end

	def self.run_setup_commands
		# run all required setup commands for rspec
		puts "\nRunning setup commands for rspec"
		system('spring stop')
		system('rails generate rspec:install')
		system('spring stop')
	end

	def self.configure_dotrspec
		# configure .rspec
		puts "\nconfiguring rspec output format in .rspec"
		open('.rspec', 'w') { |f|
			f.puts '--color'
			f.puts '--require spec_helper'
			f.puts '--format progress'
			f.puts '--format html'
			f.puts '--out spec/rspec_results.html'
		}
	end

	def self.modify_spec_helper
		puts "Adding require 'simplecov' and SimpleCov.Start"
		open('spec/spec_helper.rb', 'r'){ |f|
			simple_flag = false
			@contents = f.readlines
			@contents.each do |i|
				if i.include? "require 'simplecov'"
					simple_flag = true
				end
			end
			unless simple_flag
				@contents.each_with_index {|i, index|
					if i.include? "RSpec.configure do |config|\n"
						@contents[index] = i + "  require 'simplecov'\n  SimpleCov.start\n"
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

end