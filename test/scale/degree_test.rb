require "helper"

class MusicTheory::Scale::DegreeTest < Minitest::Test

  context "MusicTheory::Scale::Degree" do

    context ".reduce" do

      setup do
        @result = MusicTheory::Scale::Degree.reduce(35)
      end

      should "reflect correct scale degree" do
        assert_equal 11, @result
      end

    end

  end

end
