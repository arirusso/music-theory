module MusicTheory

  module Chord

    DICTIONARY = {
      :triad => {
        :major => {
          :abbrev => :Maj,
          :symbol => "M",
          :intervals => [0, 4, 7]
        },
        :minor => {
          :abbrev => :Min,
          :symbol => "m",
          :intervals => [0, 3, 7]
        },
        :diminished => {
          :abbrev => :Dim,
          :symbol => "°",
          :intervals => [0, 3, 6]
        },
        :augmented => {
          :abbrev => :Aug,
          :symbol => "+",
          :intervals => [0, 4, 8]
        }
      },
      :seventh => {
        :minor => {
          :abbrev => :Min7,
          :symbol => "m7",
          :intervals => [0, 3, 7, 10]
        },
        :major => {
          :abbrev => :Maj7,
          :symbol => "M7",
          :intervals => [0, 4, 7, 11]
        },
        :dominant => {
          :abbrev => "7",
          :intervals => [0, 4, 7, 10]
        },
        :augmented => {
          :abbrev => :Aug7,
          :symbol => "+7",
          :intervals => [0, 4, 8, 10]
        },
        :diminished => {
          :abbrev => :Dim7,
          :symbol => "°7",
          :intervals => [0, 3, 6, 9]
        },
        :half_diminished => {
          :abbrev => "m7♭5",
          :symbol => "ø7",
          :intervals => [0, 3, 6, 10]
        }
      },
      :ninth => {
        :major => {
          :abbrev => :Maj9,
          :symbol => "M9",
          :intervals => [0, 4, 7, 11, 14]
        },
        :minor => {
          :abbrev => :Min9,
          :symbol => "m9",
          :intervals => [0, 3, 7, 10, 14]
        },
        :dominant => {
          :abbrev => "9",
          :intervals => [0, 4, 10, 14],
          :optional_intervals => [7]
        },
        :added => {
          :abbrev => :Add9,
          :intervals => [0, 4, 7, 14]
        },
        :six_nine => {
          :abbrev => "6/9",
          :intervals => [0, 4, 7, 9, 14]
        }
      },
      :eleventh => {
        :major => {
          :abbrev => :Maj11,
          :symbol => "M11",
          :intervals => [0, 11, 14, 18],
          :optional_intervals => [4, 7]
        },
        :minor => {
          :abbrev => :Min11,
          :symbol => "m11",
          :intervals => [0, 3, 10, 14, 17],
          :optional_intervals => [7]
        },
        :dominant => {
          :abbrev => "11",
          :intervals => [0, 10, 14, 17],
          :optional_intervals => [4, 7]
        }
      }
    }

  end
end
