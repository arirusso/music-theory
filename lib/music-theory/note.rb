require "music-theory/note/symbol"
require "music-theory/note/value"

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

    def number(options = {})
      octave = options[:octave] || @symbol.octave
      unless octave.nil?
        octave_start = (12 * octave) + 12
        octave_start + interval_above_c
      end
    end
    alias_method :num, :number
    alias_method :midi_note_num, :number

    def mod
      Value.mod(@symbol)
    end

    def interval_above_c
      Value.to_interval_above_c(@symbol)
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

  end

end
