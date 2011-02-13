module Alacarte
  def self.included(other_module)
    other_module.instance_eval do 
      include Helpers
    end

    ::Rspec.configure do |config|
      config.after :each do 
        File.open("#{DOCS_PATH}/#{underscored_description}.html", "w") do |f|
          f.puts buffer
        end
      end
    end

    Capybara.default_driver = :selenium

    Capybara.class_eval do
      def screenshot(*args)
        builder.img src: filename_for(*args), 
                    alt: example.metadata[:description]
        page.screenshot filename_for(*args)
      end
      
      def filename_for(*args)
        "#{DOCS_PATH}/#{args[0] || default_filename }.png"
      end
      
      def default_filename
        "#{underscored_description}_#{Time.now.to_i}"
      end
    end

    Capybara::Session.class_eval do
      def screenshot(output)
        driver.screenshot output
      end
    end

    Capybara::Driver::Selenium.class_eval do
      def screenshot(output)
        browser.save_screenshot(output)
      end
    end
  end

  module Helpers
    def doc(*args)
      annotate builder, *args
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

    def underscored_description
      example.metadata[:description].downcase.gsub(/\s/, "_")
    end
  end
end

