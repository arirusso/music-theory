module MusicTheory

  module Scale

    class Degree

      class << self

        # Convert a number to scale degree
        # eg 35 becomes 11
        # @param [Fixnum] degree
        # @return [Fixnum]
        def collapse(degree)
          degree % 12
        end

        # Convert a set of numbers to scale degrees
        # eg [13, 2, 35] -> [1, 2, 11]
        # @param [Array<Fixnum>] degrees
        # @return [Array<Fixnum>]
        def collapse_all(degrees)
          degrees.map { |n| collapse(n) }
        end

        # Transpose the given degrees so that the lowest one is zero
        # eg [16, 22, 12] -> [4, 10, 0]
        # @param [Array<Fixnum>] degrees
        # @return [Array<Fixnum>]
        def normalize(degrees)
          degrees.map { |n| n - degrees.min }
        end

      end

    end

  end

end
