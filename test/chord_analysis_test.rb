require "helper"

class ChordAnalysisTest < Minitest::Test

  def test_major
    id = MusicTheory::ChordAnalysis.find(13,17,19)
    assert_equal(true, id.has_attribute?(:major))
    assert_equal(0, id.inversion)
  end

  def test_major_first_inversion
    id = MusicTheory::ChordAnalysis.find(17,13,19)
    assert_equal(true, id.has_attribute?(:major))
    assert_equal(1, id.inversion)
  end

  def test_minor
    id = MusicTheory::ChordAnalysis.find(13,16,19)
    assert_equal(true, id.has_attribute?(:minor))
    assert_equal(0, id.inversion)
  end

  def test_minor_first_inversion
    id = MusicTheory::ChordAnalysis.find(16,13,19)
    assert_equal(true, id.has_attribute?(:minor))
    assert_equal(1, id.inversion)
  end

  def test_split_third
    id = MusicTheory::ChordAnalysis.find(13,16,17,19)
    assert_equal(true, id.has_attribute?(:split_third))
  end

  def test_major_seventh
    id = MusicTheory::ChordAnalysis.find(16,12,18,23)
    assert_equal(true, id.has_attribute?(:major_seventh))
  end

  def test_collapsed
    result = MusicTheory::ChordAnalysis.collapsed [15,13,17,11]
    assert_equal([3,1,5,11], result)
  end

  def test_normalized
    result = MusicTheory::ChordAnalysis.normalized [15,13,17]
    assert_equal([2,0,4], result)
  end

end
