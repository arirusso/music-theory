require "music-theory/chord/analysis"
require "music-theory/chord/dictionary"
require "music-theory/chord/raw"
require "music-theory/chord/voicing"

module MusicTheory

  module Chord

    def self.new(*args)
      Raw.new(*args)
    end

    def self.name(*notes)
      chord = identify(*notes)
      chord.name unless chord.nil?
    end

    def self.identify(*notes)
      notes = [notes].flatten
      notes = notes.map { |note| note.kind_of?(Note) ? note : Note.new(note) }
      Raw.analyze(notes)
    end

  end

end
