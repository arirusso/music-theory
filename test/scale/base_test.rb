require "helper"

class MusicTheory::Scale::BaseTest < Minitest::Test

  context "MusicTheory::Scale::Base" do

    context "#initialize" do

      setup do
        @scale = MusicTheory::Scale::Base.new(:major, 1,3,4,5,7,9,11)
      end

      should "populate" do
        assert_equal(:major, @scale.name)
        assert_equal(7, @scale.degrees.size)
      end

    end

    context "#degree" do

      setup do
        @scale = MusicTheory::Scale::Base.new(:major, 1,3,4,5,7,9,11)
      end

      should "return correct interval" do
        assert_equal(5, @scale.degree(7))
      end

    end

    context "#interval" do

      setup do
        @scale = MusicTheory::Scale::Base.new(:major, 1,3,4,5,7,9,11)
      end

      should "return correct degree" do
        assert_equal(7, @scale.interval(5))
      end

    end

  end

end
