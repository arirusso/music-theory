module MusicTheory

  module Chord

    class Voicing

      attr_reader :inversion, :members, :name, :root, :type

      def self.find_all(type, notes)
        names = DICTIONARY[type].keys
        chords = names.map do |name|
          unless (permutation_sets = interval_permutations(type, name, notes)).empty?
            permutation_sets.uniq.map do |set|
              {
                root_index: set.index(0),
                name: name
              }
            end
          end
        end
        chords.flatten!
        chords.compact!
        chords.uniq!
        chords.map { |chord| new(type, chord[:name], notes, :root_index => chord[:root_index]) }
      end

      def initialize(type, name, notes, options = {})
        @name = name.to_sym
        @type = type.to_sym
        populate(notes, :root_index => options[:root_index])
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

      def populate(notes, options = {})
        root_index = options[:root_index]
        @root = notes[root_index]
        map = notes.map do |note|
          (note.interval_above_c + 12) - @root.interval_above_c
        end
        map = Interval.reduce(map)
        dict = dictionary[:intervals]
        unless dictionary[:optional_intervals].nil?
          dict += dictionary[:optional_intervals]
          dict.sort!
        end
        reduced_dict = Interval.reduce(dict)
        map = map.map { |int| int if reduced_dict.include?(int) }
        @inversion = reduced_dict.index(map.compact.first)
        @members = []
        map.each_with_index do |int, i|
          unless int.nil?
            @members << notes[i]
          end
        end
        populate_name
        @members
      end

      def populate_name
        type = dictionary[:abbrev].to_s
        @name = "#{@root.name}#{@root.accidental}#{type}"
      end

      # filter out permutations where extended notes aren't actually extended
      # eg, 11th is actually a 4th
      def self.filter_for_extended(sets, dictionary_intervals, notes)
        sets.select do |permutation|
          root_index = permutation.index(0)
          extended = dictionary_intervals.select { |n| n if n > 11 }
          reduced_extended = extended.map { |n| n % 12 }
          i = 0
          extended_indexes = permutation.map do |n|
            index = i if reduced_extended.include?(n)
            i += 1
            index
          end
          extended_indexes.compact!
          extended_notes = extended_indexes.map { |i| notes[i] }
          root = notes.at(root_index)
          extended_notes.all? { |note| note.midi_note_num - root.midi_note_num > 12 }
        end
      end

      def self.interval_permutations(type, name, notes)
        dictionary = DICTIONARY[type.to_sym][name.to_sym]
        controls = [dictionary[:intervals], Interval.reduce(dictionary[:intervals])]
        unless (optional_intervals = dictionary[:optional_intervals]).nil?
          controls << (dictionary[:intervals] + optional_intervals)
          controls << Interval.reduce(dictionary[:intervals] + optional_intervals)
        end
        # find matching reduced permutations
        permutations = Interval::Set.permutations(notes).select do |intervals|
          controls.any? { |control| control & intervals == control }
        end
        # are we dealing with extended notes?
        has_octave = notes.all?(&:octave?)
        if has_octave && dictionary[:intervals].max > 11
          filter_for_extended(permutations, dictionary[:intervals], notes)
        else
          permutations
        end
      end

    end

  end

end
