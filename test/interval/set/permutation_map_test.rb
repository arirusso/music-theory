require "helper"

class MusicTheory::Interval::Set::PermutationMapTest < Minitest::Test

  context "MusicTheory::Interval::Set::PermutationMap" do

    context "#calculate" do

      context "starting on zero" do

        setup do
          @set = MusicTheory::Interval::Set::Base.new(0, 2, 4, 5, 7, 9, 11)
          @map = MusicTheory::Interval::Set::PermutationMap.new(@set)
          @result = @map.calculate
        end

        should "return results" do
          refute_nil @result
          refute_empty @result
        end

      end

      context "not starting on zero" do

        setup do
          @set = MusicTheory::Interval::Set::Base.new(5, 9, 7, 10, 14, 16, 24)
          @map = MusicTheory::Interval::Set::PermutationMap.new(@set)
          @result = @map.calculate
        end

        should "return results" do
          refute_nil @result
          refute_empty @result
        end

      end

    end

  end

end
