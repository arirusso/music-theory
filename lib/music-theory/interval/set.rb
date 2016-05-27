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

      def initialize(*members)
        @members = members.flatten
      end

      def combinations
        combinations = []
        @members.count.times do |i|
          last = combinations.last || @members
          index = Interval.index_of_lowest(last, :rating => 2)
          combinations << Interval.center(last, :index => index)
        end
        combinations
      end

      def reduce
        Set.new(primitive_reduce)
      end

      def reduce!
        @members = primitive_reduce
      end

      def normalize
        Set.new(primitive_normalize)
      end

      def normalize!
        @members = primitive_normalize
      end

      def sort
        Set.new(primitive_sort)
      end

      def sort!
        @members = primitive_sort
      end

      def uniq
        Set.new(primitive_uniq)
      end

      def uniq!
        @members = uniq.members
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

    end

  end
end
