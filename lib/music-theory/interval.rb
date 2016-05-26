module MusicTheory

  class Interval

    class << self

      def find(notes)
        notes.map { |note| note.midi_note_num || note.interval_above_c }
      end

      def map(notes)
        numbers = if notes.all? { |n| n.kind_of?(Fixnum) }
          notes
        else
          find(notes)
        end
        reduced_members = reduce(numbers)
        normalize(reduced_members)
      end

      # Convert a set of numbers to scale degrees
      # eg [13, 2, 35] -> [1, 2, 11]
      # @param [Array<Fixnum>] degrees
      # @return [Array<Fixnum>]
      def reduce(intervals)
        intervals.map { |n| Scale::Degree.reduce(n) }
      end

      # Transpose the given intervals so that the lowest one is zero
      # eg [16, 22, 12] -> [4, 10, 0]
      # @param [Array<Fixnum>] intervals
      # @return [Array<Fixnum>]
      def normalize(intervals)
        intervals.map { |n| n - intervals.min }
      end

      # Center the intervals around zero
      def center(intervals)
        center = intervals.sort[1]
        intervals
          .map { |n| n - center }
          .map { |n| n < 0 ? n + 12 : n }
      end

    end

  end
end
