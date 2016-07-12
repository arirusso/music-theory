module MusicTheory

  class Scale

    DICTIONARY = {
      :heptatonic => {
        :mode => {
          :ionian => [0, 2, 4, 5, 7, 9, 11],  # 0 / C maj [],
          :dorian => [0, 2, 3, 5, 7, 9, 10], # 2 / D min[]
          :phrygian => [0, 1, 3, 5, 7, 8, 10], # 3 min [],
          :lydian => [0, 2, 4, 6, 7, 9, 11],  # 5 maj [],
          :mixolydian => [0, 2, 4, 5, 7, 9, 10], # 7 maj [],
          :aeolian => [0, 2, 3, 5, 7, 8, 10], # 9  min[],
          :locrian => [0, 1, 3, 5, 6, 8, 10] # 11  dim []
        },
        :diatonic => {
          :major => [0, 2, 4, 5, 7, 9, 11],
          :minor => {
            :natural => [0, 2, 3, 5, 7, 8, 10],
            :harmonic => [0, 2, 3, 5, 7, 8, 11],
            :melodic => {
              :ascend => [],
              :descend => []
            }
          },
        },
      },
      :hexatonic => {
        :whole_tone => []
      },
      :pentatonic => {
        :major => [],
        :minor => []
      }
    }

    module Dictionary

      extend self

    end

  end

end
