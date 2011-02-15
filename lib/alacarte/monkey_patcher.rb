# encoding: utf-8
module Alacarte
  module MonkeyPatcher
    def raise_if_existing(*args)
      args.each do |m| 
        if instance_methods.include?(m)
          raise "Method '#{m}' exists, Alacarte will not override!" 
        end
      end
    end
  end
end
