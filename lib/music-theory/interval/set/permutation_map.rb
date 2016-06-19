module MusicTheory

  module Interval

    module Set

      class PermutationMap

        def self.calculate(set)
          @permutations = new(set)
          @permutations.calculate
        end

        def initialize(set)
          @set = set
        end

        def calculate
          if @permutations.nil?
            permutations = centered(@set.members)
            permutations += variations(permutations)
            permutations.uniq!
            @permutations = permutations
          end
          @permutations
        end

        private

        def variations(permutations)
          permutations.map { |set| Interval.reduce(set) } +
            permutations.map { |set| Interval.normalize(set) }
        end

        def centered(intervals)
          permutations = []
          num_passes = intervals.count * 2
          num_passes.times do |i|
            last = permutations.last
            last = intervals if last.nil? || i.zero?
            index = Interval.index_of_lowest(last, :rating => 2)
            permutations << Interval.center(last, :index => index)
          end
          permutations
        end

      end

    end

  end

end
