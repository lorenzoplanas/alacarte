# encoding utf-8
require_relative "alacarte/rspec_extensions"
require_relative "alacarte/capybara_extensions"

module Alacarte
  class << self
    attr_accessor :docs
  end

  def self.included(other_module)
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

