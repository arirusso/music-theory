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
      # @param [Array<Fixnum>] intervals
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
      # eg w :index = 1, [12, 16, 23] -> [-4, 0, 7]
      # @params [Array<Fixnum>] intervals
      # @params [Hash] options
      # @option [Fixnum] :index
      # @return [Array<Fixnum>]
      def center(intervals, options = {})
        index = options.fetch(:index, 1)
        center = intervals.sort[index]
        intervals
          .map { |n| n - center }
          .map { |n| n < 0 ? n + 12 : n }
      end

      # Take a set of notes and turn it into sequential intervals
      # eg [16, 22, 12] -> [0, 6, -10]
      # @params [Array<Fixnum>] intervals
      # @return [Array<Fixnum>]
      def sequential(intervals)
        intervals = center(intervals, :index => 0)
        intervals.enum_for(:each_with_index).map do |n, i|
          index = [i - 1, 0].max
          n - intervals[index]
        end
      end

    end

  end
end
