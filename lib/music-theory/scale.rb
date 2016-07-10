require "music-theory/scale/analysis"
require "music-theory/scale/builder"
require "music-theory/scale/degree"
require "music-theory/scale/dictionary"

module MusicTheory

  module Scale

    extend self

    def build(name, options = {})
      Builder.build(name, options)
    end

  end

end
