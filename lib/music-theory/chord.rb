require "music-theory/chord/analysis"
require "music-theory/chord/builder"
require "music-theory/chord/dictionary"
require "music-theory/chord/match"
require "music-theory/chord/name"
require "music-theory/chord/raw"
require "music-theory/chord/voicing"

module MusicTheory

  module Chord

    extend self

    def new(*args)
      if builder_args?(args)
        Builder.build(args[0], :octave => args[1])
      else
        Raw.new(*args)
      end
    end

    def name(*notes)
      chord = identify(*notes)
      chord.name unless chord.nil?
    end

    def identify(*notes)
      notes = [notes].flatten
      notes = notes.map { |note| note.kind_of?(Note) ? note : Note.new(note) }
      Raw.analyze(notes)
    end

    def build(string, options = {})
      Builder.build(string, options)
    end

    private

    def builder_args?(args)
      args.size <= 2 &&
        (args[0].kind_of?(String) || args[0].kind_of?(Symbol)) &&
        (args[1].nil? || args[1].kind_of?(Fixnum))
    end

  end

end
