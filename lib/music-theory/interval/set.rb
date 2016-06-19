module MusicTheory

  module Interval

    class Set

      extend Forwardable

      attr_reader :members
      def_delegators :@members, :size, :to_a

      def self.from_notes(notes)
        degrees = notes.map { |note| note.midi_note_num || note.interval_above_c }
        new(degrees)
      end

      def self.permutations(notes)
        set = from_notes(notes)
        set.permutations
      end

      def initialize(*members)
        @members = members.flatten
      end

      def permutations
        Permutations.new(self).to_a
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
        Interval.normalize(@members)
      end

      def primitive_reduce
        Interval.reduce(@members)
      end

      def primitive_uniq
        @members.uniq
      end

      def primitive_sort
        @members.sort
      end

      class Permutations

        def initialize(set)
          @set = set
          populate_permutations
        end

        def to_a
          @permutations
        end

        private

        def variations(permutations)
          permutations.map { |set| Interval.reduce(set) } +
            permutations.map { |set| Interval.normalize(set) }
        end

        def centered(intervals)
          permutations = []
          num_passes = intervals.count * 2
          num_passes.times do |i|
            last = permutations.last
            last = intervals if last.nil? || i.zero?
            index = Interval.index_of_lowest(last, :rating => 2)
            permutations << Interval.center(last, :index => index)
          end
          permutations
        end

        def populate_permutations
          permutations = centered(@set.members)
          permutations += variations(permutations)
          permutations.uniq!
          @permutations = permutations
        end

      end

    end

  end
end
