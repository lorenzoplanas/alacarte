# encoding: utf-8
module RSpec
  module Core
    class Example
      [:underscored_description, :buffer, :builder].each do |e| 
        if instance_methods.include?(e)
          raise "Method '#{e}' exists, Alacarte will not override!" 
        end
      end

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
end
