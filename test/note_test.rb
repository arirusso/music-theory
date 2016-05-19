require "helper"

class NoteTest < Minitest::Test

  context "Note" do

    context "#name" do

      should "capitalize" do
        note = MusicTheory::Note.new("c")
        assert_equal("C", note.name)
      end

      should "convert sym to string and not reflect octave" do
        note = MusicTheory::Note.new(:c4)
        assert_equal("C", note.name)
      end

      should "convert int to string" do
        note = MusicTheory::Note.new(48)
        assert_equal("C", note.name)
      end

      should "not reflect accidental (sharp)" do
        note = MusicTheory::Note.new("G#")
        assert_equal("G", note.name)
      end

      should "convert sym to string and not reflect octave or accidental" do
        note = MusicTheory::Note.new(:fs4)
        assert_equal("F", note.name)
      end

      should "capitalize and not reflect octave" do
        note = MusicTheory::Note.new("d3")
        assert_equal("D", note.name)
      end

      should "not reflect octave or accidental (flat)" do
        note = MusicTheory::Note.new("Cb5")
        assert_equal("C", note.name)
      end

    end

    context "#id" do

      should "capitalize" do
        note = MusicTheory::Note.new("c")
        assert_equal("C", note.id)
      end

      should "convert sym to string and reflect octave" do
        note = MusicTheory::Note.new(:c4)
        assert_equal("C4", note.id)
      end

      should "convert int to string and reflect octave" do
        note = MusicTheory::Note.new(48)
        assert_equal("C3", note.id)
      end

      should "reflect accidental (sharp)" do
        note = MusicTheory::Note.new("F#")
        assert_equal("#", note.accidental)
      end

      should "convert sym to string and reflect octave and accidental" do
        note = MusicTheory::Note.new(:fs4)
        assert_equal("F#4", note.id)
      end

      should "capitalize and reflect octave" do
        note = MusicTheory::Note.new("d3")
        assert_equal("D3", note.id)
      end

      should "reflect octave and accidental (flat)" do
        note = MusicTheory::Note.new("Cb5")
        assert_equal("Cb5", note.id)
      end

    end

    context "#accidental" do

      should "not reflect natural" do
        note = MusicTheory::Note.new("c")
        assert_nil(note.accidental)
      end

      should "convert sym to note and not reflect natural" do
        note = MusicTheory::Note.new(:c4)
        assert_nil(note.accidental)
      end

      should "convert int to note and not reflect natural" do
        note = MusicTheory::Note.new(48)
        assert_nil(note.accidental)
      end

      should "reflect sharp" do
        note = MusicTheory::Note.new("F#")
        assert_equal("#", note.accidental)
      end

      should "convert sym to string and reflect accidental" do
        note = MusicTheory::Note.new(:fs4)
        assert_equal("#", note.accidental)
      end

      should "not reflect natural when there's an octave" do
        note = MusicTheory::Note.new("d3")
        assert_nil(note.accidental)
      end

      should "reflect flat" do
        note = MusicTheory::Note.new("Cb5")
        assert_equal("b", note.accidental)
      end

    end

    context "#octave" do

      should "not reflect unspecified octave" do
        note = MusicTheory::Note.new("c")
        assert_nil(note.octave)
      end

      should "convert sym and reflect correct octave" do
        note = MusicTheory::Note.new(:c4)
        assert_equal(4, note.octave)
      end

      should "convert int and reflect correct octave" do
        note = MusicTheory::Note.new(48)
        assert_equal(3, note.octave)
      end

      should "convert string with sharp and not reflect unspecified octave" do
        note = MusicTheory::Note.new("F#")
        assert_nil(note.octave)
      end

      should "convert sym with sharp and reflect correct octave" do
        note = MusicTheory::Note.new(:fs4)
        assert_equal(4, note.octave)
      end

      should "convert string and reflect correct octave" do
        note = MusicTheory::Note.new("d3")
        assert_equal(3, note.octave)
      end

      should "convert string with flat and reflect correct octave" do
        note = MusicTheory::Note.new("Cb5")
        assert_equal(5, note.octave)
      end

    end

    context "#midi_note_num" do

      should "convert sym and reflect correct midi note" do
        note = MusicTheory::Note.new(:c3)
        assert_equal(48, note.midi_note_num)
      end

      should "convert string and reflect correct midi note" do
        note = MusicTheory::Note.new("c4")
        assert_equal(60, note.midi_note_num)
      end

      should "convert int and reflect correct midi note" do
        note = MusicTheory::Note.new(55)
        assert_equal("G3", note.id)
        assert_equal(3, note.octave)
        assert_equal(55, note.midi_note_num)
      end

      should "not reflect midi note when octave is unspecified" do
        note = MusicTheory::Note.new("B")
        assert_nil note.midi_note_num
      end

    end

    context "#mod" do

      context "flat" do

        should "reflect value of accidental" do
          note = MusicTheory::Note.new("Cb5")
          assert_equal(-1, note.mod)
        end

      end

      context "double flat" do

        should "reflect value of accidental" do
          note = MusicTheory::Note.new("Dbb4")
          assert_equal(-2, note.mod)
        end

      end

      context "sharp" do

        should "reflect value of accidental" do
          note = MusicTheory::Note.new("G#2")
          assert_equal(1, note.mod)
        end

      end

      context "double sharp" do

        should "reflect value of accidental" do
          note = MusicTheory::Note.new("G##2")
          assert_equal(2, note.mod)
        end

      end

      context "natural" do

        should "reflect no mode for natural" do
          note = MusicTheory::Note.new("B1")
          assert_equal(0, note.mod)
        end

      end

    end

  end

end
