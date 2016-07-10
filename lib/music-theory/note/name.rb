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
          @names[string] ||= {}
          if @names[string][options].nil?
            name_hash = Parser.parse(string)
            name_options = name_hash.merge!(options)
            @names[string][options] = new(name_options[:letter], name_options)
          end
          @names[string][options]
        end

      end

      def initialize(letter, options = {})
        @accidental = options[:accidental]
        @octave = options[:octave]
        @letter = letter.to_s
        @value = Value.for_name(self)
        freeze
      end

      def freeze
        @accidental.freeze
        @letter.freeze
        @octave.freeze
        super
      end

      def flatten(options = {})
        factor = options.fetch(:factor, 1)
        tonality = options.fetch(:tonality, Scale.build("C", :major))
      end

      def sharp(options = {})
        factor = options.fetch(:factor, 1)
        tonality = options.fetch(:tonality, Scale.build("C", :major))
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
          to_s === Parser.parse_to_string(o)
        else
          to_s === o.to_s
        end
      end
      alias_method :eql?, :==

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

        def parse_to_string(string)
          hash = parse(string)
          "#{hash[:letter]}#{hash[:accidental]}#{hash[:octave]}"
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
