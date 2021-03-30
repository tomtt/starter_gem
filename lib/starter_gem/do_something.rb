require "pastel"

Encoding.default_external = "UTF-8"

module StarterGem
  class DoSomething
    def initialize(options, out: stdout, err: stderr)
      @options = options
      @out = out
      @err = err
    end

    def show
      pastel = Pastel.new
      output_text = if pastel.respond_to?(@options[:color])
                      pastel.send(@options[:color], @options[:color])
                    else
                      "? #{@options[:color]}"
                    end
      puts output_text
    end
  end
end
