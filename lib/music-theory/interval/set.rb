require "music-theory/interval/set/base"
require "music-theory/interval/set/permutation_map"

module MusicTheory
  module Interval
    module Set

      class << self

        def new(*a, &block)
          Base.new(*a, &block)
        end

        def from_notes(notes)
          degrees = notes.map { |note| note.value.number || note.value.interval_above_c }
          new(degrees)
        end

        def permutations(notes)
          set = from_notes(notes)
          set.permutations
        end

      end

    end
  end
end
