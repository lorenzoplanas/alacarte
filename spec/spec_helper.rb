# encoding: utf-8
require "bundler/setup"
Bundler.require :test
require_relative "../lib/alacarte"

Alacarte.docs = "#{File.dirname(__FILE__)}/docs"

RSpec.configure do |config|
  config.include Alacarte
end
