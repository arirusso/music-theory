require "music-theory/note/name"
require "music-theory/note/value"

module MusicTheory

  module Note

    def self.new(*args)
      Note::Name.find(*args)
    end

  end

end
