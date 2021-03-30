require "pastel"
require "curses"

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
      Curses.init_screen

      begin
        Curses.start_color
        Curses.noecho
        # Curses.cbreak
        Curses.init_pair(1, Curses::COLOR_BLACK, Curses::COLOR_YELLOW)
        Curses.attrset(Curses.color_pair(1) | Curses::A_BLINK)
        10.times do |i|
          Curses.setpos(i,5*i)
          Curses.addstr("Hello #{i+1}/10")
          Curses.getch
        end
      ensure
        Curses.close_screen
        puts output_text
      end
    end
  end
end
