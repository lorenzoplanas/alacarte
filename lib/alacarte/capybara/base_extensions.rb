# encoding: utf-8
require_relative "../monkey_patcher"
module Alacarte
  module CapybaraExtensions
    extend MonkeyPatcher
    raise_if_existing :doc, :annotated_helpers, :annotate, :narrate,
                      :screenshot, :filename_for, :default_filename

    def doc(*args)
      annotate example.builder, *args
    end

    def annotated_helpers
      ::Capybara::Node::Actions.instance_methods + [:visit]
    end

    def annotate(builder, *args)
      if args[0].is_a?(String)
        builder.p args[0]
      elsif annotated_helpers.include?(args[0])
        builder.p narrate(args)
        self.send(*args)
      end
    end

    def narrate(args)
      args.flat_map { |arg|
        arg.is_a?(Hash) ? arg.each { |k, v| [k,v] } : arg.to_s
      }.join(" ")
    end

    def screenshot(*args)
      example.builder.img src: filename_for(*args), 
                          alt: example.description
      page.screenshot filename_for(*args)
    end
      
    def filename_for(*args)
      "#{Alacarte.docs || "."}/#{ args[0] || default_filename }.png"
    end
      
    def default_filename
      "#{example.underscored_description}_#{Time.now.to_i}"
    end
  end
end

module Capybara
  include ::Alacarte::CapybaraExtensions
end
