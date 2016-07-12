module MusicTheory

  class Scale

    class Degree

      class << self

        # Convert a number to scale degree
        # eg 35 becomes 11
        # @param [Fixnum] degree
        # @return [Fixnum]
        def reduce(degree)
          degree % 12
        end

      end

    end

  end

end
