module MusicTheory

  module Chord

    module Builder

      extend self

      def build(name, options = {})
        name = Chord::Name.new(name, octave: options[:octave])
        dictionary = Dictionary.find_by_abbreviation(name.abbreviation)
        notes = notes(name, dictionary)
        Voicing.new(dictionary, notes, name.root, octave: options[:octave])
      end

      private

      def notes(chord_name, dictionary)
        root_number = chord_name.root.value.number || chord_name.root.value.interval_above_c
        intervals = (dictionary[:intervals] + (dictionary[:optional_intervals] || [])).sort!
        note_numbers = intervals.map { |n| n + root_number }
        note_numbers.map { |n| Note.find(n) }
      end

    end

  end

end
