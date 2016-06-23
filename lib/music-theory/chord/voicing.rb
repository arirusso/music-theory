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

      def self.as_intervals(type, name, notes)
        dictionary = DICTIONARY[type.to_sym][name.to_sym]
        controls = [dictionary[:intervals], Interval.reduce(dictionary[:intervals])]
        unless (optional_intervals = dictionary[:optional_intervals]).nil?
          controls << (dictionary[:intervals] + optional_intervals)
          controls << Interval.reduce(dictionary[:intervals] + optional_intervals)
        end
        Interval::Set.permutations(notes).select do |intervals|
          controls.any? { |control| control & intervals == control }
        end
      end

    end

  end

end
