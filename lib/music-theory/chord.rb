require "music-theory/chord/analysis"
require "music-theory/chord/dictionary"
require "music-theory/chord/seventh"
require "music-theory/chord/triad"
require "music-theory/chord/voicing"

module MusicTheory

  module Chord

    def self.new(*args)
      Voicing.new(*args)
    end

    def self.identify(*notes)
      notes = [notes].flatten
      notes = notes.map { |note| note.kind_of?(Note) ? note : Note.new(note) }
      Voicing.analyze(notes)
    end

  end

end
