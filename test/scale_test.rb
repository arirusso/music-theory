require "helper"

class ScaleTest < Minitest::Test

  def test_scale_init
    scale = MusicTheory::Scale.new(:major, 1,3,4,5,7,9,11)
    assert_equal(:major, scale.name)
    assert_equal(7, scale.degrees.size)
  end

  def test_scale_degree
    scale = MusicTheory::Scale.new(:major, 1,3,4,5,7,9,11)
    assert_equal(5, scale.degree(7))
  end

  def test_scale_interval
    scale = MusicTheory::Scale.new(:major, 1,3,4,5,7,9,11)
    assert_equal(7, scale.interval(5))
  end

end
