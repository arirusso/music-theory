require "helper"

class MusicTheory::Interval::Set::PermutationMapTest < Minitest::Test

  context "MusicTheory::Interval::Set::PermutationMap" do

    context ".uniq_notes" do

      setup do
        @notes = [0, 4, 7, 12, 16, 19]
        @result = MusicTheory::Interval::Set::PermutationMap.send(:uniq_notes, @notes)
      end

      should "return unique note values" do
        refute_nil @result
        refute_empty @result
        refute_equal @notes, @result
        assert_equal [0, 4, 7, nil, nil, nil], @result
      end

    end

    context "#calculate" do

      context "starting on zero" do

        setup do
          @set = MusicTheory::Interval::Set.new(0, 2, 4, 5, 7, 9, 11)
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
          @set = MusicTheory::Interval::Set.new(5, 9, 7, 10, 14, 16, 24)
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
