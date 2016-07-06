module MusicTheory

  module Note

    class Value

      include Comparable

      attr_reader :mod, :number, :interval_above_c

      def self.load_or_create(interval_above_c, options = {})
        @values ||= {}
        @values[interval_above_c] ||= {}
        @values[interval_above_c][options] ||= new(interval_above_c, options)
      end

      def self.for_name(name)
        @values ||= {}
        if @values[name].nil?
          interval = Calculate.interval_above_c(name)
          number = Calculate.number(name)
          mod = Calculate.mod(name)
          @values[name] = Value.load_or_create(interval, :number => number, :mod => mod)
        end
        @values[name]
      end

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

        def number(name)
          unless name.abstract?
            octave_start = (12 * name.octave) + 12
            octave_start + interval_above_c(name)
          end
        end

        # The intervalic value of this note's accidental
        # @return [Fixnum]
        def mod(name)
          mod = 0
          unless name.accidental.nil?
            name.accidental.each_char do |char|
              mod += case char
              when /♯/ then 1
              when /♭/ then -1
              end
            end
          end
          mod
        end

        def interval_above_c(name)
          scale_degree = Name::NAME.keys.index(name.name.downcase.to_sym)
          number = Scale::Analysis::SCALE[:major][scale_degree]
          number + mod(name)
        end

      end

    end

  end

end
