require "music-theory/note/id"
require "music-theory/note/instance"

module MusicTheory

  module Note

    def self.new(*args)
      MusicTheory::Note::Instance.new(*args)
    end

  end

end
