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

      SCALE = {
        :major => [0, 2, 4, 5, 7, 9, 11],
        :minor => {
          :natural => [0, 2, 3, 5, 7, 8, 10],
          :harmonic => [0, 2, 3, 5, 7, 8, 11],
          :melodic => [
            [],
            []
          ]
        },
        :pentatonic => {
          :major => [],
          :minor => []
        },
        :whole_tone => []
      }

      def initialize(set)
        @set = set
      end

      def scale
        # TODO make less strict ?
        # if there are more than 7, try iterating thru, removing the extra ones
        scale = SCALE.key(reduce.to_a)
        if scale.nil?
          nested = SCALE.values.select { |val| val.kind_of?(Hash) }
          nested.any? do |hash|
            if name = hash.key(reduce.to_a)
              scale = { SCALE.key(hash) => name }
            end
          end
        end
        scale
      end

      def mode
        members = reduce
        i = 0
        until scale?(members)
          members.rotate!.last += 12
          members.normalize!
          i += 1
        end
        MODE[i]
      end

      private

      def scale?(members)
        !SCALE.key(members.to_a).nil?
      end

      def reduce
        @set.collapse.normalize.uniq.sort
      end

    end

  end

end
