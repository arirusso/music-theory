require "music-theory/interval/set/functions"
require "music-theory/interval/set/permutation_map"

module MusicTheory

  module Interval

    class Set

      extend Forwardable
      extend Functions

      attr_reader :members
      def_delegators :@members, :size, :to_a

      def initialize(*members)
        @members = members.flatten
      end

      def permutations
        PermutationMap.calculate(self)
      end

      def reduce
        Set.new(primitive_reduce)
      end

      def reduce!
        @members = primitive_reduce
        self
      end

      def normalize
        Set.new(primitive_normalize)
      end

      def normalize!
        @members = primitive_normalize
        self
      end

      def sort
        Set.new(primitive_sort)
      end

      def sort!
        @members = primitive_sort
        self
      end

      def uniq
        Set.new(primitive_uniq)
      end

      def uniq!
        @members = uniq.members
        self
      end

      def ==(o)
        (o.class == self.class) && o.members == @members
      end
      alias_method :eql?, :==

      private

      def primitive_normalize
        Interval::Set.normalize(@members)
      end

      def primitive_reduce
        Interval::Set.reduce(@members)
      end

      def primitive_uniq
        @members.uniq
      end

      def primitive_sort
        @members.sort
      end

      class << self

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
