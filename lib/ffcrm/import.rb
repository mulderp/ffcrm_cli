require './config/environment' # if File.exists?('./config/environment')
require 'csv'
  
module FFCRM
  class Import
    def initialize(args)
      @file_name = args[:file]
      @resource = args[:resource]
      @attributes = args[:attributes]
    end

    def run
      puts "[ffcrm_cli] Run import ..."
      puts "[ffcrm_cli] Use file: #{@file_name}"
      f = File.new(@file_name)
      puts "[ffcrm_cli] Use attributes from CLI header: #{@attributes}"
      @klass = Kernel.const_get(@resource.classify)
      ls = f.readlines
      ls.each do |l|
        l = l.gsub("\r","").gsub("\n","") if l.class == String
        import_resource(l)
      end
#      CSV.foreach(@file_name, :headers => true ) do |row|
#        name = row["Name"]
#        Account.create(:user => User.first, :name => name)
#      end
    end

    def import_resource(str)
      fields = str.split(";")
      object = @klass.send("find_by_#{@attributes[0]}", fields[0])
      object ||= @klass.create(fields)
      object
    end
  end
end
