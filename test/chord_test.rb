require "helper"

class ChordTest < Minitest::Test

  def test_chord_init
    chord = MusicTheory::Chord.new("a", "B")
    assert_equal(2, chord.members.size)
    assert_equal(true, chord.members.first.name == "A")
    assert_equal(true, chord.members.last.name == "B")
  end

  def test_chord_brackets
    chord = MusicTheory::Chord["a", "B"]
    assert_equal(2, chord.members.size)
  end

  def test_chord_mixed
    chord = MusicTheory::Chord["a", :b]
    assert_equal(2, chord.members.size)
  end

  def test_chord_array
    chord = MusicTheory::Chord.new %w{a c d# f}
    assert_equal(4, chord.members.size)
  end

  def test_chord_attributes
    chord = MusicTheory::Chord.new(0,4,7)
    assert_equal(chord.members[0].name, "C")
    assert_equal(chord.members[1].name, "E")
    assert_equal(chord.members[2].name, "G")
    assert_equal(true, chord.attributes.include?(:major))
  end

end
