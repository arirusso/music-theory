module MusicTheory

  module Chord

    module Builder

      extend self

      def build(name, options = {})
        name = Chord::Name.new(name, octave: options[:octave])
        dictionary = Dictionary.find_by_abbreviation(name.abbreviation)
        notes = notes(name, dictionary, options)
        Voicing.new(dictionary, notes, name.root)
      end

      private

      def notes(chord_name, dictionary, options = {})
        root_number = if options[:octave].nil?
          chord_name.root.value.interval_above_c
        else
          chord_name.root.value.number
        end
        optional_intervals = dictionary[:optional_intervals] || []
        intervals = (dictionary[:intervals] + optional_intervals).sort!
        if !options[:inversion].nil?
          intervals.rotate!(options[:inversion])
        end
        note_numbers = intervals.map { |n| n + root_number }
        note_numbers.map { |n| Note.find(n, octave: options[:octave]) }
      end

    end

  end

end
