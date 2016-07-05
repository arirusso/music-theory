require "music-theory/note/instance"
require "music-theory/note/signature"

module MusicTheory

  module Note

    def self.new(*args)
      MusicTheory::Note::Instance.new(*args)
    end

  end

end
