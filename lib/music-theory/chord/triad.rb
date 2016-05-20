module MusicTheory

  module Chord

    class Triad

      attr_reader :inversion, :name, :members, :root

      def self.find_all(notes)
        matches = DICTIONARY[:triad].keys.select { |name| matches?(name, notes) }
        matches.map { |name| new(name, notes) }
      end

      def initialize(name, notes)
        @name = name.to_sym
        populate_notes(notes)
      end

      def dictionary
        DICTIONARY[:triad][@name]
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

      def self.matches?(name, notes)
        dictionary = DICTIONARY[:triad][name.to_sym]
        intervals = Interval.map(notes)
        dictionary[:intervals] & intervals == dictionary[:intervals]
      end

      def self.get_inversion(triad, notes)
        triad = triad.dup
        i = 0
        while notes[0] != triad[0] && i < notes.count
          triad.rotate!
          i += 1
        end
        i
      end

    end

  end

end
