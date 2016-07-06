module MusicTheory

  module Note

    class Value

      include Comparable

      def initialize(symbol)
        @symbol = symbol
      end

      def <=>(o)
        self.class == o.class && number <=> o.number
      end

      def ==(o)
        o.class == self.class && number == o.number
      end
      alias_method :eql?, :==

      def number(options = {})
        octave = options[:octave] || @symbol.octave
        unless octave.nil?
          octave_start = (12 * octave) + 12
          octave_start + to_interval_above_c
        end
      end

      # The intervalic value of this note's accidental
      # @return [Fixnum]
      def mod
        mod = 0
        unless @symbol.accidental.nil?
          @symbol.accidental.each_char do |char|
            mod += case char
            when /♯/ then 1
            when /♭/ then -1
            end
          end
        end
        mod
      end

      def to_interval_above_c
        scale_degree = Symbol::NAME.keys.index(@symbol.name.downcase.to_sym)
        number = Scale::Analysis::SCALE[:major][scale_degree]
        number + mod
      end

    end

  end

end
