require "music-theory/chord/analysis"
require "music-theory/chord/voicing"

module MusicTheory

  module Chord

    def self.new(*args)
      MusicTheory::Chord::Voicing.new(*args)
    end
    
  end

end
