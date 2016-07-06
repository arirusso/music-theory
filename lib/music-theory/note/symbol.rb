module MusicTheory

  class Note

    class Symbol

      NAME = {
        :c => "c",
        :d => "d",
        :e => "e",
        :f => "f",
        :g => "g",
        :a => "a",
        :b => "b"
      }.freeze

      SHARP = %w{♯ # s}.freeze
      FLAT = %w{♭ b}.freeze

      MATCH = {
        :accidental => /^[#{NAME.values.join(',')}]([#{SHARP.join(',')},#{FLAT.join(',')},s]+)/i,
        :name => /^[#{NAME.values.join(',')}]/i,
        :octave => /\d+$/
      }.freeze

      attr_reader :accidental, :name, :octave

      class << self

        def find(obj, options = {})
          case obj
          when Array then obj.map { |member| find(member, options) }
          when Fixnum then by_number(obj, options)
          when String then by_string(obj, options)
          when ::Symbol then by_string(obj.to_s, options)
          end
        end

        def by_number(int, options = {})
          octave, note = *int.divmod(12)
          name = DEFAULT_SCALE.at(note)
          string = "#{name}#{(octave - 1)}"
          by_string(string, options)
        end

        def by_string(string, options = {})
          new(string, options)
        end

      end

      def initialize(string, options = {})
        populate(string.downcase, options)
        freeze
      end

      def freeze
        @accidental.freeze
        @name.freeze
        @octave.freeze
        super
      end

      def to_s
        "#{@name}#{@accidental}#{@octave}"
      end

      def ==(o)
        if o.kind_of?(::String)
          send(:==, Symbol.new(o))
        else
          to_s === o.to_s
        end
      end
      alias_method :eql?, :==

      private

      def populate(string, options = {})
        string = string.downcase
        populate_accidental(string, options)
        populate_name(string)
        populate_octave(string, options)
      end

      def populate_accidental(string, options = {})
        @accidental = self.class.parse_accidental(string)
        @accidental ||= options[:accidental]
        @accidental
      end

      def populate_name(string)
        @name = self.class.parse_name(string)
      end

      def populate_octave(string, options = {})
        if string.match(MATCH[:octave])
          @octave = string.match(MATCH[:octave])[0].to_i
        end
        @octave ||= options[:octave]
        @octave
      end

      def self.parse_accidental(string)
        if string.match(MATCH[:accidental])
          accidental = string.match(MATCH[:accidental])[1].downcase.to_s
          accidental.gsub!(/[#{SHARP.join(',')}]/i, SHARP.first)
          accidental.gsub!(/[#{FLAT.join(',')}]/i, FLAT.first)
          accidental
        end
      end

      def self.parse_name(string)
        if string.match(MATCH[:name])
          string.match(MATCH[:name])[0].upcase.to_s
        end
      end

    end

  end

end
