require "helper"

class MusicTheory::Chord::VoicingTest < Minitest::Test

  def test_chord_init
    chord = MusicTheory::Chord::Voicing.new("a", "B")
    assert_equal 2, chord.members.size
    assert_equal "A", chord.members.first.name
    assert_equal "B", chord.members.last.name
  end

  def test_chord_mixed
    chord = MusicTheory::Chord::Voicing.new("a", :b)
    assert_equal 2, chord.members.size
  end

  def test_chord_array
    chord = MusicTheory::Chord::Voicing.new(%w{a c d# f})
    assert_equal 4, chord.members.size
  end

  def test_chord_attributes
    chord = MusicTheory::Chord::Voicing.new(0,4,7)
    assert_equal "C", chord.members[0].name
    assert_equal "E", chord.members[1].name
    assert_equal "G", chord.members[2].name
    assert_includes chord.triad_names, :major
  end

end
