require 'optparse'

module FFCRM
  class Cli

    attr_accessor :argv

    def initialize(argv)
      @argv = argv
    end

    def run
      method = (argv.shift || 'help').to_sym
      if [:import, :export, :help].include? method
        send(method)
      else
        help
      end
    end

    def help
      puts <<EOHELP
Options
=======
import        Start a database import
export        Start a database export

Add '-h' to any command to see their usage
EOHELP
    end

    def import
      opts = optparse(:import)
      puts opts.inspect

      require 'ffcrm/import'

      FFCRM::Import.new(opts).run
    end

    def export
      opts = optparse(:export)
      puts opts.inspect

      require 'ffcrm/export'

      FFCRM::Export.new(opts).run
    end

    def optparse(cmd)
      opts={:file => nil, :debug => true, :format => :csv }
      OptionParser.new do |o|
        o.banner = "Usage: #{File.basename($0)} #{cmd} [OPTIONS] file"

        case cmd
        when :import
          o.define_head "Import data"
          # o.on("-f", "--format=xls|csv", "File import format") { |v| opts[:format] = v }
          o.on("-r", "--resource=account|user|task|opportunity", "Resource for import") { |v| opts[:resource] = v }
          o.on("-a", "--attributes=a,b,c,d", Array, "Attributes for import") { |v| opts[:attributes] = v }
        when :export
          o.define_head "Export data"
          o.on("-f", "--format=xls|csv", "File export format") { |v| opts[:format] = v }
          o.on("-r", "--resource=account|user|task|opportunity", "Resource for export") { |v| opts[:resource] = v }
          o.on("-a", "--attributes=a,b,c,d", Array, "Attributes for export") { |v| opts[:attributes] = v }
        end

        o.parse!(argv)

        opts[:file] = argv.shift

        if opts[:file].nil?
          $stderr.puts "Missing file to import/export"
          puts o
          exit 1
        end

      end
      opts
    end

  end
end
