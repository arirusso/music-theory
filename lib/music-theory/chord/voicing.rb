module MusicTheory

  module Chord

    class Voicing

      attr_reader :inversion, :members, :name, :root, :type

      def self.find_all(type, notes)
        names = DICTIONARY[type].keys
        chords = names.map do |name|
          unless (interval_sets = as_intervals(type, name, notes)).empty?
            interval_sets.uniq.map do |set|
              {
                intervals: set,
                name: name
              }
            end
          end
        end
        chords.flatten!
        chords.compact!
        chords.uniq!
        chords.map { |chord| new(type, chord[:name], notes, intervals: chord[:intervals]) }
      end

      def initialize(type, name, notes, options = {})
        intervals = options[:intervals] || self.class.as_intervals(type, name, notes)

        @name = name.to_sym
        @type = type.to_sym
        populate(notes, intervals)
      end

      def include?(note)
        @members.include?(note)
      end

      def include_relative?(note)
        @members.any? { |member| member.interval_above_c == note.interval_above_c }
      end

      def ==(o)
        (o.class == self.class) &&
          o.members == @members &&
          o.root == @root &&
          o.inversion == @inversion &&
          o.name == @name &&
          o.type == @type
      end
      alias_method :eql?, :==

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

      def populate(notes, intervals)
        # if intervals.size != dictionary[:intervals]
        # TODO for sub-chords
        @members = []

        dictionary[:intervals].each_with_index do |member, i|
          if (index = intervals.index(member)).nil?
            reduced_member = Interval.reduce(dictionary[:intervals])[i]
            index = intervals.index(reduced_member)
          end
          note = notes[index]
          @root = note if member == 0
          @members[index] = note
        end
        @members.compact!
        @inversion = dictionary[:intervals].index(intervals[0])
        populate_name
        @members
      end

      def populate_name
        type = dictionary[:abbrev].to_s
        @name = "#{@root.name}#{@root.accidental}#{type}"
      end

      def self.as_intervals(type, name, notes)
        dictionary = DICTIONARY[type.to_sym][name.to_sym]
        controls = [dictionary[:intervals], Interval.reduce(dictionary[:intervals])]
        Interval::Set.permutations(notes).select do |intervals|
          controls.any? { |control| control & intervals == control }
        end
      end

    end

  end

end
