module MusicTheory

  class Note

    module Value

      extend self

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

      def to_interval_above_c(symbol)
        scale_degree = Symbol::NAME.keys.index(symbol.name.downcase.to_sym)
        number = Scale::Analysis::SCALE[:major][scale_degree]
        number + mod(symbol)
      end

    end

  end

end
