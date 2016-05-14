require "helper"

class NoteTest < Minitest::Test

  def test_note_name
    note = MusicTheory::Note.new("c")
    assert_equal("C", note.name)
    assert_equal("C", note.id)
    assert_nil(note.accidental)
    assert_nil(note.octave)
  end

  def test_symbol_note_name
    note = MusicTheory::Note.new(:c4)
    assert_equal("C", note.name)
    assert_equal("C", note.id)
    assert_nil(note.accidental)
    assert_equal(4, note.octave)
  end

  def test_integer
    note = MusicTheory::Note.new(48)
    assert_equal("C", note.name)
    assert_equal("C3", note.id)
    assert_nil(note.accidental)
    assert_equal(3, note.octave)
  end

  def test_note_name_accidental
    note = MusicTheory::Note.new("C#")
    assert_equal("C", note.name)
    assert_equal("#", note.accidental)
    assert_equal("C#", note.id)
    assert_nil(note.octave)
  end

  def test_symbol_note_name
    note = MusicTheory::Note.new(:cs4)
    assert_equal("C", note.name)
    assert_equal("C#4", note.id)
    assert_equal("#", note.accidental)
    assert_equal(4, note.octave)
  end

  def test_note_name_octave
    note = MusicTheory::Note.new("c3")
    assert_equal("C", note.name)
    assert_equal(3, note.octave)
    assert_equal("C3", note.id)
    assert_nil(note.accidental)
  end

  def test_note_name_accidental_octave
    note = MusicTheory::Note.new("Cb5")
    assert_equal("C", note.name)
    assert_equal("b", note.accidental)
    assert_equal(5, note.octave)
    assert_equal("Cb5", note.id)
  end

  def test_mod
    note = MusicTheory::Note.new("Cb5")
    assert_equal(-1, note.mod)
  end

  def test_midi_note_num
    note = MusicTheory::Note.new(:c3)
    assert_equal(48, note.midi_note_num)
  end

end
