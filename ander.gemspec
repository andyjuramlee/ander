Gem::Specification.new do |s|
  s.name        = 'ander'
  s.version     = '1.0.29'
  s.date        = '2015-04-01'
	s.platform    = Gem::Platform::RUBY
  s.summary     = "Performs all required steps to setup rspec on rails."
  s.description = "Setup Rspec for Rails environment including all configurations and command line inputs required. Once the setup is ran, user can start run spec files without any further configurations."
  s.authors     = ["Andy Juram Lee"]
  s.email       = 'andy.lee@flipp.com'
  s.files       = ["lib/ander.rb"]
  s.homepage    =
    'https://github.com/tearshock/ander'
  s.license       = 'MIT'
	s.required_ruby_version     = '>= 1.9.3'
end
