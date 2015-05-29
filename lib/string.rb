begin
    require 'win32console'
    $isWindows = true
rescue LoadError
    $isWindows = false
end

class String
    {
        :black          => 30,
        :red            => 31,
        :green          => 32,
        :yellow         => 33,
        :blue           => 34,
        :magenta        => 35,
        :cyan           => 36,
        :gray           => 37,
    }.each do |key, value|
        define_method key do
            return self.to_console(value)
        end
    end

    def to_console(code)
        # We must close any open escape on Windows as it behaves weirdly
        if RUBY_PLATFORM =~ /(win|w)32$/
            return $isWindows ? "\e[0m\e[#{code}m#{self}\e[0m" : self
        else
            return "\033[#{code}m#{self}\033[0m"
        end
    end

    def to_desc()
        return self.word_wrap.yellow
    end

    def word_wrap(width = 80)
        width = ENV['COLUMNS'] || width
        length = 0
        output = ""

        self.scan(/\S+/).each do |w|
            output += w
            length += w.length

            if length >= width
                output += "\n"
                length = 0
            else
                output += " "
            end
        end

        return output
    end
end
