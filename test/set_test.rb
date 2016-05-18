require "helper"

class MusicTheory::SetTest < Minitest::Test

  context "MusicTheory::Set" do

    context "#initialize" do

      setup do
        @set = MusicTheory::Set.new(0, 2, 4, 5, 7, 9, 11)
      end

      should "populate" do
        assert_equal(7, @set.size)
      end

    end

    context "#collapsed" do

      setup do
        @set = MusicTheory::Set.new(19, 12, 40, 5, 35, 14, 9)
      end

      should "return collapsed set" do
        assert_equal([7, 0, 4, 5, 11, 2, 9], @set.collapsed)
      end

    end

    context "#normalized" do

      setup do
        @set = MusicTheory::Set.new(19, 12, 40, 5, 35, 14, 9)
      end

      should "return normalized set" do
        assert_equal([14, 7, 35, 0, 30, 9, 4], @set.normalized)
      end

    end

  end

end
