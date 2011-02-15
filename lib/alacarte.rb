# encoding utf-8
require_relative "alacarte/rspec_extensions"
require_relative "alacarte/capybara/base_extensions"
require_relative "alacarte/capybara/session_extensions"
require_relative "alacarte/capybara/driver_selenium_extensions"

module Alacarte
  class << self
    attr_accessor :docs
  end

  def self.included(other_module)
    Alacarte.docs ||= "#{`pwd`}/docs"
    Capybara.default_driver = :selenium
    RSpec.configure do |config|
      config.after :each do 
        File.open(
          "#{Alacarte.docs}/#{example.underscored_description}.html", "w"
        ) { |f| f.puts example.buffer }
      end
    end
  end
end
