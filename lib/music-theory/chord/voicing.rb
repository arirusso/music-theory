module MusicTheory

  module Chord

    class Voicing

      attr_reader :inversion, :name, :members, :root, :type

      def self.find_all(type, notes)
        DICTIONARY[type].keys.map do |name|
          new(type, name, notes) unless as_intervals(type, name, notes).nil?
        end.compact
      end

      def initialize(type, name, notes)
        @name = name.to_sym
        @type = type.to_sym
        populate(notes)
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

      def lowest_note
        @members.sort_by(&:midi_note_num).first
      end

      def dictionary
        DICTIONARY[@type][@name]
      end

      private

      def populate(notes)
        intervals = self.class.as_intervals(@type, @name, notes)
        # if intervals.size != dictionary[:intervals]
        # TODO for sub-chords
        @members = []
        dictionary[:intervals].each_with_index do |member, i|
          index = intervals.index(member)
          note = notes[index]
          @root = note if member == 0
          @members[index] = note
        end
        @members.compact!
        @inversion = dictionary[:intervals].index(intervals[0])
        @members
      end

      def self.as_intervals(type, name, notes)
        dictionary = DICTIONARY[type.to_sym][name.to_sym]
        intervals = Interval.find(notes)
        variations = []
        intervals.count.times do
          last = variations.last || intervals
          variations << Interval.fold(last)
        end
        variation = variations.find do |intervals|
          dictionary[:intervals] & intervals == dictionary[:intervals]
        end
      end

    end

  end

end
