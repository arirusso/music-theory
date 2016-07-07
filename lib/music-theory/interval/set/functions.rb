module MusicTheory

  module Interval

    class Set

      module Functions

        extend self

        # Convert a set of numbers to scale degrees
        # eg [13, 2, 35] -> [1, 2, 11]
        # @param [Array<Fixnum>] set
        # @return [Array<Fixnum>]
        def reduce(set)
          set.map { |n| Scale::Degree.reduce(n) }
        end

        # Convert a set of numbers to scale degrees keeping their relative intervals
        # eg [13, 14, 35] -> [1, 2, 23]
        # @param [Array<Fixnum>] set
        # @return [Array<Fixnum>]
        def reduce_relative(set)
          lowest = set.min
          lowest_reduced = Scale::Degree.reduce(lowest)
          diff = lowest - lowest_reduced
          set.map { |n| n - diff }
        end

        # Transpose the given intervals so that the lowest one is zero
        # eg [16, 22, 12] -> [4, 10, 0]
        # @param [Array<Fixnum>] set
        # @return [Array<Fixnum>]
        def normalize(set)
          set.map { |n| n - set.min }
        end

        # Center the intervals around zero
        # eg w :index = 1, [12, 16, 23] -> [-4, 0, 7]
        # @params [Array<Fixnum>] set
        # @params [Hash] options
        # @option [Fixnum] :index
        # @return [Array<Fixnum>]
        def center(set, options = {})
          index = options.fetch(:index, 1)
          center = set[index]
          set
            .map { |n| n - center unless n.nil? }
            .map { |n| n < 0 ? n + 12 : n unless n.nil? }
        end

        # Get the index of the r lowest value in the set
        # eg [17, 1, 34] -> 1
        # optional argument :rating selects the 2nd, 3rd 4th lowest
        # eg with :rating = 1, [17, 37, 34] -> 2
        # @params [Array<Fixnum>] set
        # @params [Hash] options
        # @option [Fixnum] :rating
        # @return [Fixnum]
        def index_of_lowest(set, options = {})
          rating = options.fetch(:rating, 1)
          value = set.map { |n| n || set.compact.max + 1 }.sort[rating - 1]
          set.index(value)
        end

        # Take a set of notes and turn it into sequential intervals
        # eg [16, 22, 12] -> [0, 6, -10]
        # @params [Array<Fixnum>] set
        # @return [Array<Fixnum>]
        def sequential(set)
          set.enum_for(:each_with_index).map do |n, i|
            index = [i - 1, 0].max
            n - set[index]
          end
        end

      end

    end
  end
end
