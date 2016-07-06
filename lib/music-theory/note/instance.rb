module MusicTheory

  module Note

    # An immutable note
    class Instance

      include Comparable
      extend Forwardable

      DEFAULT_SCALE = %w{c c♯ d d♯ e f f♯ g g♯ a a♯ b}.freeze

      attr_reader :signature
      def_delegators :@signature, :accidental, :name, :octave

      def initialize(id, options = {})
        populate_signature(id, options = {})
        freeze
      end

      def freeze
        @signature.freeze
        super
      end

      def <=>(o)
        num <=> o.num
      end

      def num(options = {})
        octave = options[:octave] || @signature.octave
        unless octave.nil?
          octave_start = (12 * octave) + 12
          octave_start + interval_above_c
        end
      end
      alias_method :midi_note_num, :num

      # The intervalic value of this note's accidental
      # @return [Fixnum]
      def mod
        mod = 0
        unless @signature.accidental.nil?
          @signature.accidental.each_char do |char|
            mod += case char
            when /♯/ then 1
            when /♭/ then -1
            end
          end
        end
        mod
      end

      def interval_above_c
        as_c_major_scale_degree + mod
      end

      def octave?
        !@signature.octave.nil?
      end

      def ==(o)
        o.class == self.class && @signature == o.signature
      end
      alias_method :eql?, :==

      private

      def populate_signature(obj, options = {})
        case obj
        when Array then obj.map { |member| populate_signature_from_object(member, options) }
        when Fixnum then populate_signature_from_number(obj, options)
        when String then populate_signature_from_string(obj, options)
        when Symbol then populate_signature_from_string(obj.to_s, options)
        end
      end

      # The interval of this note above C (in C Major)
      # @return [Fixnum]
      def as_c_major_scale_degree
        scale_degree = Signature::NAME.keys.index(@signature.name.downcase.to_sym)
        Scale::Analysis::SCALE[:major][scale_degree]
      end

      def populate_signature_from_number(int, options = {})
        octave, note = *int.divmod(12)
        name = DEFAULT_SCALE.at(note)
        string = "#{name}#{(octave - 1)}"
        populate_signature_from_string(string, options)
        @signature
      end

      def populate_signature_from_string(string, options = {})
        @signature = Note::Signature.new(string, options)
      end

    end

  end

end
