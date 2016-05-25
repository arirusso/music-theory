module MusicTheory

  module Chord

    class Voicing

      attr_reader :inversion, :name, :members, :root

      def self.find_all(type, notes)
        matches = DICTIONARY[type].keys.select { |name| matches?(type, name, notes) }
        matches.map { |name| new(type, name, notes) }
      end

      def initialize(type, name, notes)
        @name = name.to_sym
        @type = type.to_sym
        populate_notes(notes)
      end

      def dictionary
        DICTIONARY[@type][@name]
      end

      private

      def populate_notes(notes)
        intervals = Interval.map(notes)
        @root = nil
        i = 0
        @members = dictionary[:intervals].map do |member|
          index = intervals.index(member)
          note = notes[index]
          @root = note if i == 0
          i += 1
          note
        end
        @inversion = self.class.get_inversion(dictionary[:intervals], intervals)
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

      def self.matches?(type, name, notes)
        dictionary = DICTIONARY[type][name.to_sym]
        intervals = Interval.map(notes)
        dictionary[:intervals] & intervals == dictionary[:intervals]
      end

    end

  end

end
