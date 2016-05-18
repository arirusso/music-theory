require "helper"

class MusicTheory::Chord::AnalysisTest < Minitest::Test

  context "#inversion" do

    context "major chord, root inversion" do

      setup do
        @id = MusicTheory::Chord::Analysis.find(13,17,19)
      end

      should "be root inversion" do
        assert_equal 0, @id.inversion
      end

    end

    context "major chord, first inversion" do

      setup do
        @id = MusicTheory::Chord::Analysis.find(17,13,19)
      end

      should "be first inversion" do
        assert_equal 1, @id.inversion
      end

    end

    context "minor chord, root inversion" do

      setup do
        @id = MusicTheory::Chord::Analysis.find(13,16,19)
      end

      should "be root inversion" do
        assert_equal 0, @id.inversion
      end

    end

    context "minor chord, first inversion" do

      setup do
        @id = MusicTheory::Chord::Analysis.find(16,13,19)
      end

      should "be first inversion" do
        assert_equal 1, @id.inversion
      end

    end

    context "minor chord, second inversion" do

      setup do
        @id = MusicTheory::Chord::Analysis.find(20, 25, 28)
      end

      should "be second inversion" do
        assert_equal 2, @id.inversion
      end
    end

  end

  context "#has_attribute?" do

    context "major chord, root inversion" do

      setup do
        @id = MusicTheory::Chord::Analysis.find(13,17,19)
      end

      should "be major" do
        assert @id.has_attribute?(:major)
      end

    end

    context "major chord, first inversion" do

      setup do
        @id = MusicTheory::Chord::Analysis.find(17,13,19)
      end

      should "be major" do
        assert @id.has_attribute?(:major)
      end

    end

    context "minor chord, root inversion" do

      setup do
        @id = MusicTheory::Chord::Analysis.find(13,16,19)
      end

      should "be minor" do
        assert @id.has_attribute?(:minor)
      end

    end

    context "minor chord, first inversion" do

      setup do
        @id = MusicTheory::Chord::Analysis.find(16,13,19)
      end

      should "be minor" do
        assert @id.has_attribute?(:minor)
      end

    end

    context "minor chord, second inversion" do

      setup do
        @id = MusicTheory::Chord::Analysis.find(20, 25, 28)
      end

      should "be minor" do
        assert @id.has_attribute?(:minor)
      end

    end

    context "major seventh" do

      setup do
        @id = MusicTheory::Chord::Analysis.find(16,12,18,23)
      end

      should "have major seventh" do
        assert @id.has_attribute?(:major_seventh)
      end

    end

  end
  context ".collapsed" do

    setup do
      @result = MusicTheory::Chord::Analysis.collapsed([15,13,17,11])
    end

    should "have correct scale degrees" do
      assert_equal [3,1,5,11], @result
    end

  end

  context ".normalized" do

    setup do
      @result = MusicTheory::Chord::Analysis.normalized([15,13,17])
    end

    should "have correct scale degrees" do
      assert_equal [2,0,4], @result
    end

  end

end
