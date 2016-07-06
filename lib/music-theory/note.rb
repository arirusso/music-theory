require "music-theory/note/symbol"

module MusicTheory

  class Note

    include Comparable
    extend Forwardable

    DEFAULT_SCALE = %w{c c♯ d d♯ e f f♯ g g♯ a a♯ b}.freeze

    attr_reader :symbol
    def_delegators :@symbol, :accidental, :name, :octave

    def initialize(id, options = {})
      @symbol = Note::Symbol.find(id, options = {})
      freeze
    end

    def freeze
      @symbol.freeze
      super
    end

    def <=>(o)
      num <=> o.num
    end

    def num(options = {})
      octave = options[:octave] || @symbol.octave
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

    def interval_above_c
      as_c_major_scale_degree + mod
    end

    def abstract?
      @symbol.octave.nil?
    end

    def octave?
      !@symbol.octave.nil?
    end

    def ==(o)
      o.class == self.class && @symbol == o.symbol
    end
    alias_method :eql?, :==

    private

    # The interval of this note above C (in C Major)
    # @return [Fixnum]
    def as_c_major_scale_degree
      scale_degree = Symbol::NAME.keys.index(@symbol.name.downcase.to_sym)
      Scale::Analysis::SCALE[:major][scale_degree]
    end

  end

end
