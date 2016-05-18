module MusicTheory

  module Scale

    class Degree

      class << self

        # Convert a set of numbers to scale degrees
        def collapsed(degrees)
          degrees.map { |n| n % 12 }
        end

        # Transpose the given degrees so that the lowest one is zero
        def normalized(degrees)
          degrees.map { |n| n - degrees.min }
        end

      end

    end

  end

end
