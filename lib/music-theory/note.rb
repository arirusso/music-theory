require "music-theory/note/symbol"
require "music-theory/note/value"

module MusicTheory

  module Note

    def self.new(*args)
      Note::Symbol.find(*args)
    end

  end

end
