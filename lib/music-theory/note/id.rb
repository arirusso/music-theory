module MusicTheory

  module Note

    class ID

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
        :accidental => /^[#{NAME.values.join(',')}]([#{SHARP.join(',')},#{FLAT.join(',')},s]+)/,
        :name => /^[#{NAME.values.join(',')}]/,
        :octave => /\d+$/
      }.freeze

      attr_reader :accidental, :name, :octave

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
          send(:==, ID.new(o))
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
        if string.match(MATCH[:accidental])
          @accidental = string.match(MATCH[:accidental])[1].downcase.to_s
          @accidental.gsub!(/[#{SHARP.join(',')}]/, SHARP.first)
          @accidental.gsub!(/[#{FLAT.join(',')}]/, FLAT.first)
        end
        @accidental ||= options[:accidental]
        @accidental
      end

      def populate_name(string)
        if string.match(MATCH[:name])
          @name = string.match(MATCH[:name])[0].upcase.to_s
        end
        @name
      end

      def populate_octave(string, options = {})
        if string.match(MATCH[:octave])
          @octave = string.match(MATCH[:octave])[0].to_i
        end
        @octave ||= options[:octave]
        @octave
      end

    end

  end

end
