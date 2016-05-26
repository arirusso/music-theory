require "helper"

class MusicTheory::IntervalTest < Minitest::Test

  context "MusicTheory::Interval" do

    context ".reduce" do

      setup do
        @result = MusicTheory::Interval.reduce([15,13,17,11])
      end

      should "reflect correct intervals" do
        assert_equal [3,1,5,11], @result
      end

    end

    context ".center" do

      setup do
        @result = MusicTheory::Interval.center([0, 1, 8, 16])
      end

      should "reflect correct intervals center over zero" do
        assert_equal [11,0,7,15], @result
      end

    end

    context ".normalize" do

      setup do
        @result = MusicTheory::Interval.normalize([15,13,17])
      end

      should "reflect numbers in relation to lowest in the set" do
        assert_equal [2,0,4], @result
      end

    end

  end

end
