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
            #permutations += variations(permutations)
            #permutations.uniq!
            @permutations = permutations
          end
          @permutations
        end

        private

        def variations(permutations)
          permutations.map { |set| Interval.reduce(set) } +
            permutations.map { |set| Interval.normalize(set) }
        end

        def next_centered_permutation(set)
          index = Interval.index_of_lowest(set, :rating => 2)
          Interval.center(set, :index => index)
        end

        def centered(intervals)
          permutations = []
          num_passes = intervals.count * 2
          num_passes.times do |pass|
            last = permutations.last
            last = intervals if last.nil? || pass.zero?
            permutation = next_centered_permutation(last)
            permutations << permutation unless permutations.include?(permutation)
          end
          permutations
        end

      end

    end

  end

end