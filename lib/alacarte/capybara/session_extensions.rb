# encoding: utf-8
require_relative "../monkey_patcher"
module Alacarte
  module CapybaraSessionExtensions
    extend MonkeyPatcher
    raise_if_existing :screenshot

    def screenshot(output)
      driver.screenshot output
    end
  end
end

class Capybara::Session
  include ::Alacarte::CapybaraSessionExtensions
end
