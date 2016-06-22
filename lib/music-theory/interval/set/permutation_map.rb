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
            members = self.class.uniq_notes(@set.members)
            permutations = centered(members)
            @permutations = permutations
          end
          @permutations
        end

        def self.uniq_notes(notes)
          memo = []
          notes.map do |n|
            mod = n % 12
            if !memo.include?(mod)
              memo << mod
              n
            end
          end
        end

        private

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
