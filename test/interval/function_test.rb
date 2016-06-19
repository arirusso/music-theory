require "helper"

class MusicTheory::IntervalTest < Minitest::Test

  context "MusicTheory::Interval" do

    context ".sequential" do

      setup do
        @result = MusicTheory::Interval.sequential([15,13,17,11])
      end

      should "reflect sequential differences" do
        assert_equal [0,-2,4,-6], @result
      end

    end

    context ".index_of_lowest" do

      context "with rating" do

        setup do
          @result = MusicTheory::Interval.index_of_lowest([15,13,17,11], :rating => 2)
        end

        should "reflect the index of the second lowest value" do
          assert_equal 1, @result
        end

      end

      context "without rating" do

        setup do
          @result = MusicTheory::Interval.index_of_lowest([15,13,17,11])
        end

        should "reflect the index of the lowest value" do
          assert_equal 3, @result
        end

      end

    end

    context ".reduce" do

      setup do
        @result = MusicTheory::Interval.reduce([15,13,17,11])
      end

      should "reflect correct intervals" do
        assert_equal [3,1,5,11], @result
      end

    end

    context ".reduce_relative" do

      setup do
        @result = MusicTheory::Interval.reduce_relative([15,13,17,35])
      end

      should "reflect correct intervals" do
        assert_equal [3, 1, 5, 23], @result
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
