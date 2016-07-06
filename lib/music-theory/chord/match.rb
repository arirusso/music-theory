module MusicTheory

  module Chord

    module Match

      extend self

      # filter out permutations where extended notes aren't actually extended
      # eg, 11th is actually a 4th
      def filter_for_extended(sets, dictionary_intervals, notes)
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
          extended_notes.all? { |note| note.value.number - root.value.number > 12 }
        end
      end

      def control_sets(dictionary)
        controls = [dictionary[:intervals], Interval.reduce(dictionary[:intervals])]
        unless (optional_intervals = dictionary[:optional_intervals]).nil?
          controls << (dictionary[:intervals] + optional_intervals)
          controls << Interval.reduce(dictionary[:intervals] + optional_intervals)
        end
        controls
      end

      def match_extended_notes?(notes, dictionary)
        should_use_octave = notes.all?(&:octave?)
        should_use_octave && dictionary[:intervals].max > 11
      end

      def interval_permutations(dictionary, notes)
        controls = control_sets(dictionary)
        # find matching reduced permutations
        permutations = Interval::Set.permutations(notes).select do |intervals|
          controls.any? { |control| control & intervals == control }
        end
        if match_extended_notes?(notes, dictionary)
          filter_for_extended(permutations, dictionary[:intervals], notes)
        else
          permutations
        end
      end

    end

  end

end
