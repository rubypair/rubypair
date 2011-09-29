#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

def load_rails_environment
  require File.expand_path('../config/application', __FILE__)
  require 'rake'
  Rubypair::Application.load_tasks
end

# By default, do not load the Rails environment. This allows for faster
# loading of all the rake files, so that getting the task list, or kicking
# off a spec run (which loads the environment by itself anyways) is much
# quicker.
if ENV['LOAD_RAILS'] == '1'
  # Bypass these hacks that prevent the Rails environment loading, so that the
  # original descriptions and tasks can be seen, or to see other rake tasks provided
  # by gems.
  load_rails_environment
else
  # Create a stub task for all Rails provided tasks that will load the Rails
  # environment, which in will append the real definition of the task to
  # the end of the stub task, so it will be run directly afterwards.
  #
  # Refresh this list with:
  # LOAD_RAILS=1 rake -T | ruby -ne 'puts $_.split(/\s+/)[1]' | tail -n+2 | xargs
  %w(
    about db:create db:drop db:fixtures:load db:migrate db:migrate:status
    db:rollback db:schema:dump db:schema:load db:seed db:setup
    db:structure:dump db:version doc:app log:clear middleware notes
    notes:custom rails:template rails:update routes secret stats
    time:zones:all tmp:clear tmp:create
  ).each do |task_name|
    desc task_name
    task task_name do
      load_rails_environment
      # Explicitly invoke the rails environment task so that all configuration
      # gets loaded before the actual task (appended on to this one) runs.
      Rake::Task['environment'].invoke
    end
  end
end

# Load all tasks defined in lib/tasks/*.rake
Dir[File.expand_path("../lib/tasks/", __FILE__) + '/*.rake'].each do |file|
  load file
end

require 'rspec'
require 'rspec/core/rake_task'

desc "Non-rails specs"
RSpec::Core::RakeTask.new(:snr) do |t|
  t.pattern = ["./spec/presenters/*_spec.rb", "./spec/domain_models/*_spec.rb"]
  t.skip_bundler = true
end

desc "All specs"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = "-r spec_helper"
end

task default: :spec
