require './config/environment' # if File.exists?('./config/environment')
require 'csv'
  
module FFCRM
  class Import
    def initialize(args)
      @file_name = args[:file]
      @resource = args[:resource]
      @header = args[:attributes]
    end

    def run
      puts "[ffcrm_cli] Run import ..."
      puts "[ffcrm_cli] Use file: #{@file_name}"
      f = File.new(@file_name)
      puts "[ffcrm_cli] Use header from CLI header: #{@header}"
      @klass = Kernel.const_get(@resource.classify)
      ls = f.readlines
      ls[1..-1].each do |l|
        l = l.gsub("\r","").gsub("\n","") if l.class == String
        res = import_resource(l)
        puts res.inspect
      end
#      CSV.foreach(@file_name, :headers => true ) do |row|
#        name = row["Name"]
#        Account.create(:user => User.first, :name => name)
#      end
    end

    def import_resource(str)
      fields = str.split(";")
      @hash = {}
      @header.each_with_index { |key, i| @hash[key.to_sym] = fields[i].strip if fields[i] }

      object = @klass.send("find_by_#{@header[0]}", fields[0].strip)
      if object
        object.update_attributes(@hash)
      else
        object ||= @klass.create(@hash)
      end
      object
    end
  end
end
