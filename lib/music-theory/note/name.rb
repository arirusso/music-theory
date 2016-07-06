module MusicTheory

  module Note

    class Name

      LETTER = {
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

      attr_reader :accidental, :letter, :octave, :value

      class << self

        DEFAULT_SCALE = %w{c c♯ d d♯ e f f♯ g g♯ a a♯ b}.freeze

        def find(obj, options = {})
          case obj
          when Array then obj.map { |member| find(member, options) }
          when Fixnum then find_by_number(obj, options)
          when String then find_by_string(obj, options)
          when Symbol then find_by_string(obj.to_s, options)
          end
        end

        def find_by_number(int, options = {})
          octave, note = *int.divmod(12)
          name = DEFAULT_SCALE.at(note)
          string = "#{name}#{(octave - 1)}"
          find_by_string(string, options)
        end

        def find_by_string(string, options = {})
          @names ||= {}
          if @names[string].nil?
            name_hash = Parser.parse(string)
            name_options = name_hash.merge!(options)
            if @names[name_options].nil?
              @names[name_options] = new(name_options[:letter], name_options)
            end
            @names[string] = @names[name_options]
          end
          @names[string]
        end

      end

      def initialize(string, options = {})
        populate(string.downcase, options)
        @value = Value.for_name(self)
        freeze
      end

      def freeze
        @accidental.freeze
        @letter.freeze
        @octave.freeze
        super
      end

      def octave?
        !@octave.nil?
      end

      def abstract?
        !octave?
      end

      def to_s
        "#{@letter}#{@accidental}#{@octave}"
      end

      def ==(o)
        if o.kind_of?(::String)
          self === Name.find(o)
        else
          super ||
          to_s === o.to_s ||
          (abstract? && o.abstract? && value.interval_above_c == o.value.interval_above_c) ||
          (!abstract? && !o.abstract? && value.number == o.value.number)
        end
      end
      alias_method :eql?, :==

      private

      def populate(string, options = {})
        string = string.downcase
        populate_accidental(string, options)
        populate_letter(string)
        populate_octave(string, options)
      end

      def populate_accidental(string, options = {})
        @accidental = Parser.accidental(string)
        @accidental ||= options[:accidental]
        @accidental
      end

      def populate_letter(string)
        @letter = Parser.letter(string)
      end

      def populate_octave(string, options = {})
        @octave = Parser.octave(string)
        @octave ||= options[:octave]
        @octave
      end

      module Parser

        extend self

        MATCH = {
          :accidental => /^[#{LETTER.values.join(',')}]([#{SHARP.join(',')},#{FLAT.join(',')},s]+)/i,
          :letter => /^[#{LETTER.values.join(',')}]/i,
          :octave => /\d+$/
        }.freeze

        def parse(string)
          {
            accidental: accidental(string),
            letter: letter(string),
            octave: octave(string)
          }
        end

        def accidental(string)
          if string.match(MATCH[:accidental])
            accidental = string.match(MATCH[:accidental])[1].downcase.to_s
            accidental.gsub!(/[#{SHARP.join(',')}]/i, SHARP.first)
            accidental.gsub!(/[#{FLAT.join(',')}]/i, FLAT.first)
            accidental
          end
        end

        def letter(string)
          if string.match(MATCH[:letter])
            string.match(MATCH[:letter])[0].upcase.to_s
          end
        end

        def octave(string)
          if string.match(MATCH[:octave])
            string.match(MATCH[:octave])[0].to_i
          end
        end

      end

    end

  end

end