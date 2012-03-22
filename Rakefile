#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

#require 'rake/dsl_definition'

require File.expand_path('../config/application', __FILE__)

EightyThousandHours::Application.load_tasks

secret_path = "#{ENV['HOME']}/.80000hours_secrets.rb"
require secret_path if File.exists?( secret_path ) 

task :run => [:set_development_environment] do
    sh "rails server -u"
end

