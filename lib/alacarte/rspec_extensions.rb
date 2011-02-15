# encoding: utf-8
require_relative "monkey_patcher"
module Alacarte
  module RSpecExtensions
    extend MonkeyPatcher
    raise_if_existing :underscored_description, :buffer, :builder

    def underscored_description
      description.downcase.gsub(/\s/, "_")
    end

    def buffer
      @buffer ||= ""
    end

    def builder
      @builder ||= Builder::XmlMarkup.new target: self.buffer, indent: 2 
    end
  end
end

class RSpec::Core::Example
  include ::Alacarte::RSpecExtensions
end
