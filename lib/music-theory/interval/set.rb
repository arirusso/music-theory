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

      def interval(degree)
        @members.at(degree - 1)
      end

      def degree(interval)
        @members.index(interval) + 1
      end

      def collapse
        members = Interval.reduce(@members)
        Set.new(members)
      end

      def collapse!
        @members = collapse.members
      end

      def normalize
        members = Interval.normalize(@members)
        Set.new(members)
      end

      def normalize!
        @members = normalize.members
      end

      def sort
        Set.new(@members.sort)
      end

      def sort!
        @members = sort.members
      end

      def uniq
        Set.new(@members.uniq)
      end

      def uniq!
        @members = uniq.members
      end

      def ==(o)
        (o.class == self.class) && o.members == @members
      end
      alias_method :eql?, :==

    end

  end
end
