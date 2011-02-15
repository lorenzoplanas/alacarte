# encoding: utf-8
require_relative "../monkey_patcher"
module Alacarte
  module CapybaraDriverSeleniumExtensions
    extend MonkeyPatcher
    raise_if_existing :screenshot

    def screenshot(output)
      browser.save_screenshot(output)
    end
  end
end

class Capybara::Driver::Selenium
  include ::Alacarte::CapybaraDriverSeleniumExtensions
end
