module MusicTheory

  module Chord

    module Builder

      extend self

      def self.build(name, options = {})
        name = Name.new(name, octave: options[:octave])
        root_number = name.root.value.number
        intervals = Dictionary.find_all_intervals_by_abbreviation(name.abbreviation)
        note_numbers = intervals.map { |n| n + root_number }
        notes = note_numbers.map { |n| Note.find(n) }

      end

    end

  end

end
