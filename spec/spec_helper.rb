require 'spork'
require 'rspec'

Spork.prefork do
  # This code is run only once when the spork server is started

  ENV["RACK_ENV"] ||= 'test'
  RACK_ENV = ENV["RACK_ENV"] unless defined?(RACK_ENV)

  module Goliath ; ROOT_DIR = File.expand_path(File.join(File.dirname(__FILE__), '..')) ; end
  require File.join(File.dirname(__FILE__), '../lib/use_gemfile_jail')
  require 'rspec'
  require 'goliath'
  require 'goliath/test_helper'
  require 'senor_armando/spec/he_help_me_test'

  # Requires custom matchers & macros, etc from files in ./support/ & subdirs
  Dir[Goliath.root_path("spec/support/**/*.rb")].each {|f| require f}

  # Configure rspec
  RSpec.configure do |config|
    config.include Goliath::TestHelper, :example_group => { :file_path => %r{spec/integration} }
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.
end
