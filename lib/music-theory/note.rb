require "music-theory/note/name"
require "music-theory/note/value"

module MusicTheory

  module Note

    class << self

      def new(*args)
        Note::Name.find(*args)
      end
      alias_method :find, :new

    end

  end

end
