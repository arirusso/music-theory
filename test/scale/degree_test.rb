require "helper"

class MusicTheory::Scale::DegreeTest < Minitest::Test

  context "MusicTheory::Scale::Degree" do

    context ".collapse" do

      setup do
        @result = MusicTheory::Scale::Degree.collapse(35)
      end

      should "reflect correct scale degree" do
        assert_equal 11, @result
      end

    end

    context ".collapse_all" do

      setup do
        @result = MusicTheory::Scale::Degree.collapse_all([15,13,17,11])
      end

      should "reflect correct scale degrees" do
        assert_equal [3,1,5,11], @result
      end

    end

    context ".normalize" do

      setup do
        @result = MusicTheory::Scale::Degree.normalize([15,13,17])
      end

      should "reflect numbers in relation to lowest in the set" do
        assert_equal [2,0,4], @result
      end

    end

  end

end
