module MusicTheory

  module Chord

    module Builder

      extend self

      def self.build(name, options = {})
        name = Name.new(name, octave: options[:octave])
        root_number = name.root.value.number
        dictionary = Dictionary.find_by_abbreviation(name.abbreviation)
        intervals = (dictionary[:intervals] + (dictionary[:optional_intervals] || [])).sort!
        note_numbers = intervals.map { |n| n + root_number }
        notes = note_numbers.map { |n| Note.find(n) }
        Voicing.new(dictionary, notes, name.root, octave: options[:octave])
      end

    end

  end

end
