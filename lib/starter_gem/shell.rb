require "optparse"

module StarterGem
  class Shell
    BANNER = <<~"MSG".freeze
      usage: #{$PROGRAM_NAME} color

      Simple demo that prints color in the color if it knows about the color
    MSG

    def self.usage(err: $stderr)
      err.puts BANNER
      exit 1
    end

    def self.run(argv, out: $stdout, err: $stderr)
      options = gather_options(argv)

      out.puts "version: #{StarterGem::VERSION}" if options.delete(:show_version)

      usage(err: err) unless argv.size == 1

      options[:color] = argv[0]

      yield(options)
    end

    def self.gather_options(argv) # rubocop:disable Metrics/MethodLength
      options = {
        show_version: false
      }

      OptionParser.new { |parser|
        parser.banner = BANNER

        parser.on("-v", "--version", "Show version") do |version|
          options[:show_version] = version
        end

        parser.on("-h", "--help", "Prints this help") do
          puts parser
          exit
        end
      }.parse! argv

      options
    end
  end
end
