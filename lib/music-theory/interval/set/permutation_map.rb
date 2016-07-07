module MusicTheory

  module Interval

    class Set

      class PermutationMap

        FACTOR = 3.freeze

        def self.calculate(set)
          @permutations = new(set)
          @permutations.calculate
        end

        def initialize(set)
          @set = set
        end

        def calculate
          if @permutations.nil?
            members = self.class.send(:uniq_notes, @set.members)
            permutations = self.class.send(:centered, members)
            @permutations = permutations
          end
          @permutations
        end

        class << self

          private

          def uniq_notes(set)
            memo = []
            set.map do |n|
              mod = n % 12
              if !memo.include?(mod)
                memo << mod
                n
              end
            end
          end

          def next_centered_permutation(set)
            index = Interval::Set.index_of_lowest(set, :rating => 2)
            Interval::Set.center(set, :index => index)
          end

          def centered(intervals)
            permutations = []
            num_passes = intervals.count * FACTOR
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

end
