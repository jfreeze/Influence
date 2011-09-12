require 'rubygems'
require 'rake'
require 'awesome_print'
require "#{File.dirname(__FILE__)}/config/startup"

task :default do
end

desc "create database influence"
task "create" do
  cmd = "mysqladmin -u root create influence"
  puts cmd
  system cmd
end

desc "migrate database influence"
task "migrate" do
  require 'connect'
  Sequel.extension :migration
  Sequel::Migrator.apply(DB, File.join(File.dirname(__FILE__), "db", "migrations"))
end

desc "reset the database influence"
task "reset" do
  require 'connect'
  Sequel.extension :migration
  Sequel::Migrator.apply(DB, File.join(File.dirname(__FILE__), "db", "migrations"), 0)
end