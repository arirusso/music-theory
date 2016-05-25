module MusicTheory

  module Chord

    class Voicing

      attr_reader :inversion, :name, :members, :root

      def self.find_all(type, notes)
        DICTIONARY[type].keys.map do |name|
          intervals = match_intervals(type, name, notes)
          new(type, name, notes) unless intervals.nil?
        end.compact
      end

      def initialize(type, name, notes)
        @name = name.to_sym
        @type = type.to_sym
        populate_notes(notes)
      end

      def size
        @members.size
      end

      def triad?
        @type == :triad
      end

      def seventh?
        @type == :seventh
      end

      def dictionary
        DICTIONARY[@type][@name]
      end

      private

      def populate_notes(notes)
        intervals = self.class.match_intervals(@type, @name, notes)
        # if intervals.size != dictionary[:intervals]
        # TODO
        @root = nil
        i = 0
        @members = dictionary[:intervals].map do |member|
          index = intervals.index(member)
          note = notes[index]
          @root = note if member == 0
          i += 1
          note
        end
        base = @root.interval_above_c
        nums = notes.map(&:interval_above_c)
        ints = nums.map { |n| n-base }
        ints = Interval.normalize(ints)
        @inversion = dictionary[:intervals].index(ints[0])
        @members
      end

      def self.get_inversion(intervals, notes)
        intervals = intervals.dup
        i = 0
        while notes[0] != intervals[0] && i < notes.count
          intervals.rotate!
          i += 1
        end
        i
      end

      def self.match_intervals(type, name, notes)
        dictionary = DICTIONARY[type.to_sym][name.to_sym]
        intervals = Interval.find(notes)
        variations = []
        intervals.count.times do
          last = variations.last || intervals
          variations << Interval.fold(last)
        end
        variations.find do |intervals|
          dictionary[:intervals] & intervals == dictionary[:intervals]
        end
      end

    end

  end

end
