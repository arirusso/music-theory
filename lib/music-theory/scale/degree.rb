module MusicTheory

  module Scale

    class Degree

      class << self

        def collapsed(degrees)
          degrees.map { |n| n % 12 }
        end

        def normalized(degrees)
          degrees.map { |n| n - degrees.min }
        end

      end

    end

  end

end
