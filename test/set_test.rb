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

    context "#collapse" do

      setup do
        @set = MusicTheory::Set.new(19, 12, 40, 5, 35, 14, 9)
      end

      should "return collapsed set" do
        assert_equal([7, 0, 4, 5, 11, 2, 9], @set.collapse.to_a)
      end

    end

    context "#normalize" do

      setup do
        @set = MusicTheory::Set.new(19, 12, 40, 5, 35, 14, 9)
      end

      should "return normalized set" do
        assert_equal([14, 7, 35, 0, 30, 9, 4], @set.normalize.to_a)
      end

    end

    context "#==" do

      setup do
        @set1 = MusicTheory::Set.new(19, 12, 40, 5, 35, 14, 9)
        @set2 = MusicTheory::Set.new(19, 12, 40, 5, 35, 14, 9)
        @set3 = MusicTheory::Set.new(19, 12, 41, 6, 19, 12, 9)
      end

      should "match same set" do
        assert @set1 == @set2
        assert_equal(@set1, @set2)
      end

      should "not match different set" do
        refute @set2 == @set3
        refute_equal(@set2, @set3)
      end

    end

    context "#uniq" do

      setup do
        @set = MusicTheory::Set.new(19, 12, 40, 5, 35, 5, 14, 9, 9, 40)
      end

      should "return normalized set" do
        assert_equal([19, 12, 40, 5, 35, 14, 9], @set.uniq.to_a)
      end

    end

    context "#sort" do

      setup do
        @set = MusicTheory::Set.new(19, 12, 40, 5, 35, 5, 14, 9, 9, 40)
      end

      should "return normalized set" do
        assert_equal([5, 5, 9, 9, 12, 14, 19, 35, 40, 40], @set.sort.to_a)
      end

    end

  end

end
