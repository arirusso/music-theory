module MusicTheory

  module Chord

    class Voicing

      attr_reader :inversion, :members, :name, :root, :type

      def self.find_all(type, notes)
        names = DICTIONARY[type].keys
        matching_names = names.reject { |name| as_intervals(type, name, notes).nil? }
        matching_names.map { |name| new(type, name, notes) }
      end

      def initialize(type, name, notes)
        @name = name.to_sym
        @type = type.to_sym
        populate(notes)
      end

      def include?(note)
        @members.include?(note)
      end

      # Get the name of the chord
      # @return [Symbol]
      def name
        type = dictionary[:abbrev].to_s
        type[0] = type[0].upcase
        (@root.name + type).to_sym
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
