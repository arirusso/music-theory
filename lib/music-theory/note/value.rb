module MusicTheory

  module Note

    class Value

      include Comparable

      attr_reader :mod, :number, :interval_above_c

      def initialize(interval_above_c, options = {})
        @mod = options[:mod]
        @number = options[:number]
        @interval_above_c = interval_above_c
      end

      def <=>(o)
        self.class == o.class && @number <=> o.number
      end

      def ==(o)
        o.class == self.class && @number == o.number
      end
      alias_method :eql?, :==

      module Calculate

        extend self

        def from_symbol(symbol)
          interval = interval_above_c(symbol)
          number = number(symbol)
          mod = mod(symbol)
          Value.new(interval, :number => number, :mod => mod)
        end

        private

        def number(symbol)
          unless symbol.abstract?
            octave_start = (12 * symbol.octave) + 12
            octave_start + interval_above_c(symbol)
          end
        end

        # The intervalic value of this note's accidental
        # @return [Fixnum]
        def mod(symbol)
          mod = 0
          unless symbol.accidental.nil?
            symbol.accidental.each_char do |char|
              mod += case char
              when /♯/ then 1
              when /♭/ then -1
              end
            end
          end
          mod
        end

        def interval_above_c(symbol)
          scale_degree = Symbol::NAME.keys.index(symbol.name.downcase.to_sym)
          number = Scale::Analysis::SCALE[:major][scale_degree]
          number + mod(symbol)
        end

      end

    end

  end

end
