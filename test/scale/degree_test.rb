require "helper"

class MusicTheory::Scale::DegreeTest < Minitest::Test

  context "MusicTheory::Scale::Degree" do

    context ".collapsed" do

      setup do
        @result = MusicTheory::Scale::Degree.collapsed([15,13,17,11])
      end

      should "have correct scale degrees" do
        assert_equal [3,1,5,11], @result
      end

    end

    context ".normalized" do

      setup do
        @result = MusicTheory::Scale::Degree.normalized([15,13,17])
      end

      should "have correct scale degrees" do
        assert_equal [2,0,4], @result
      end

    end

  end

end
