# encoding: utf-8
require "bundler/setup"
require_relative "../lib/alacarte"
Bundler.require :test

Rspec.configure do |config|
  config.include Alacarte
end
Alacarte::DOCS_PATH = "#{File.dirname(__FILE__)}/docs"
