module MusicTheory

  module Chord

    DICTIONARY = {
      :triad => {
        :major => {
          :abbrev => :maj,
          :symbol => "M",
          :intervals => [0, 4, 7]
        },
        :minor => {
          :abbrev => :min,
          :symbol => "m",
          :intervals => [0, 3, 7]
        },
        :diminished => {
          :abbrev => :dim,
          :symbol => "°",
          :intervals => [0, 3, 6]
        },
        :augmented => {
          :abbrev => :aug,
          :symbol => "+",
          :intervals => [0, 4, 8]
        }
      },
      :seventh => {
        :minor => {
          :abbrev => :min7,
          :symbol => "m7",
          :intervals => [0, 3, 7, 10]
        },
        :major => {
          :abbrev => :maj7,
          :symbol => "M7",
          :intervals => [0, 4, 7, 11]
        },
        :dominant => {
          :abbrev => "7",
          :intervals => [0, 4, 7, 10]
        },
        :augmented => {
          :abbrev => :aug7,
          :symbol => "+7",
          :intervals => [0, 4, 8, 10]
        },
        :diminished => {
          :abbrev => :dim7,
          :symbol => "°7",
          :intervals => [0, 3, 6, 9]
        },
        :half_diminished => {
          :abbrev => "m7♭5",
          :symbol => "ø7",
          :intervals => [0, 3, 6, 10]
        }
      }
    }

  end
end
