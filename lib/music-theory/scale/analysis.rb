module MusicTheory

  module Scale

    class Analysis

      MODE = [
        :ionian,  # 0 / C maj [0, 2, 4, 5, 7, 9, 11],
        :dorian, # 2 / D min[0, 2, 3, 5, 7, 9, 10]
        :phrygian, # 3 min [0, 1, 3, 5, 7, 8, 10],
        :lydian,  # 5 maj [0, 2, 4, 6, 7, 9, 11],
        :mixolydian, # 7 maj [0, 2, 4, 5, 7, 9, 10],
        :aeolian, # 9  min[0, 2, 3, 5, 7, 8, 10],
        :locrian, # 11  dim [0, 1, 3, 5, 6, 8, 10]
      ]

      DIATONIC = {
        :major => [0, 2, 4, 5, 7, 9, 11],
        :minor => []
      }

      def initialize(set)
        @set = set
      end

      def diatonic
        # TODO make less strict ?
        # if there are more than 7, try iterating thru, removing the extra ones
        degrees = @set.collapse.normalize.uniq.sort
        DIATONIC.key(degrees.to_a)
      end

      def mode
      end

    end

  end

end
