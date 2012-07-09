require './config/environment' # if File.exists?('./config/environment')
require 'csv'
  
module FFCRM
  class Export
    def initialize(args)
      @file_name = args[:file]
      @resource = args[:resource]
      @attributes = args[:attributes]
    end

    def run
      puts "[ffcrm_cli] Run export ..."
      puts "[ffcrm_cli] Create file: #{@file_name}"
      f = File.new(@file_name, "w")
      puts "[ffcrm_cli] Write header: #{@attributes}"
      f.write(@attributes.join(";") + "\r\n")
      klass = Kernel.const_get(@resource.classify)
      puts "[ffcrm_cli] Write resources: #{@attributes}"
      klass.all.each do |resource|
        str = export_attributes(resource)
        puts str
        f.write("#{str}\n\r")
      end
      f.close
    end

    def export_attributes(object)
      s = []
      @attributes.each do |attr|
        s << %Q(#{object.send(attr)})
      end
      s.join(";")
    end
  end

    
end
