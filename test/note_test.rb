require "helper"

class MusicTheory::Note::InstanceTest < Minitest::Test

  context "Note::Instance" do

    context "#==" do

      context "doesn't have octave / doesn't have octave" do

        should "match when note is the same" do
          @note1 = MusicTheory::Note.new("D")
          @note2 = MusicTheory::Note.new("d")
          assert_equal @note1, @note2
        end

        should "not match when note is not the same" do
          @note1 = MusicTheory::Note.new("E")
          @note2 = MusicTheory::Note.new("A")
          refute_equal @note1, @note2
        end

      end

      context "has octave / doesn't have octave" do

        should "not match when note is the same" do
          @note1 = MusicTheory::Note.new("E1")
          @note2 = MusicTheory::Note.new("e")
          refute_equal @note1, @note2
        end

        should "not match when note is different" do
          @note1 = MusicTheory::Note.new("F2")
          @note2 = MusicTheory::Note.new("d")
          refute_equal @note1, @note2
        end

      end

      context "has octave / has octave" do

        should "match when note and octave are the same" do
          @note1 = MusicTheory::Note.new("G#2")
          @note2 = MusicTheory::Note.new("g#2")
          assert_equal @note1, @note2
        end

        should "not match when note is the same but octave is different" do
          @note1 = MusicTheory::Note.new("F#2")
          @note2 = MusicTheory::Note.new("F#1")
          refute_equal @note1, @note2
        end

        should "not match when note and octave are different" do
          @note1 = MusicTheory::Note.new("C#2")
          @note2 = MusicTheory::Note.new("A1")
          refute_equal @note1, @note2
        end

      end

    end

    context "#name" do

      should "capitalize" do
        note = MusicTheory::Note.new("c")
        assert_equal("C", note.letter)
      end

      should "convert sym to string and not reflect octave" do
        note = MusicTheory::Note.new(:c4)
        assert_equal("C", note.letter)
      end

      should "convert int to string" do
        note = MusicTheory::Note.new(48)
        assert_equal("C", note.letter)
      end

      should "not reflect accidental (sharp)" do
        note = MusicTheory::Note.new("G#")
        assert_equal("G", note.letter)
      end

      should "convert sym to string and not reflect octave or accidental" do
        note = MusicTheory::Note.new(:fs4)
        assert_equal("F", note.letter)
      end

      should "capitalize and not reflect octave" do
        note = MusicTheory::Note.new("d3")
        assert_equal("D", note.letter)
      end

      should "not reflect octave or accidental (flat)" do
        note = MusicTheory::Note.new("Cb5")
        assert_equal("C", note.letter)
      end

    end

    context "#id" do

      should "capitalize" do
        note = MusicTheory::Note.new("c")
        assert_equal note, "C"
      end

      should "convert sym to string and reflect octave" do
        note = MusicTheory::Note.new(:c4)
        assert_equal note, "C4"
      end

      should "convert int to string and reflect octave" do
        note = MusicTheory::Note.new(48)
        assert_equal note, "C3"
      end

      should "reflect accidental (sharp)" do
        note = MusicTheory::Note.new("F#")
        assert_equal("♯", note.accidental)
      end

      should "convert sym to string and reflect octave and accidental" do
        note = MusicTheory::Note.new(:fs4)
        assert_equal note, "F♯4"
      end

      should "capitalize and reflect octave" do
        note = MusicTheory::Note.new("d3")
        assert_equal note, "D3"
      end

      should "reflect octave and accidental (flat)" do
        note = MusicTheory::Note.new("Cb5")
        assert_equal note, "C♭5"
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
        note = MusicTheory::Note.new("F♯")
        assert_equal("♯", note.accidental)
      end

      should "convert sym to string and reflect accidental" do
        note = MusicTheory::Note.new(:fs4)
        assert_equal("♯", note.accidental)
      end

      should "not reflect natural when there's an octave" do
        note = MusicTheory::Note.new("d3")
        assert_nil(note.accidental)
      end

      should "reflect flat" do
        note = MusicTheory::Note.new("Cb5")
        assert_equal("♭", note.accidental)
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

    context "#interval_above_c" do

      should "return the correct interval for c" do
        note = MusicTheory::Note.new("c")
        assert_equal(0, note.value.interval_above_c)
      end

      should "return the correct interval for d" do
        note = MusicTheory::Note.new("d")
        assert_equal(2, note.value.interval_above_c)
      end

      should "return the correct interval for e" do
        note = MusicTheory::Note.new("e")
        assert_equal(4, note.value.interval_above_c)
      end

      should "return the correct interval for Bb" do
        note = MusicTheory::Note.new("bb")
        assert_equal(10, note.value.interval_above_c)
      end

    end

    context "#midi_note_num" do

      should "convert sym and reflect correct midi note" do
        note = MusicTheory::Note.new(:c3)
        assert_equal(48, note.value.number)
      end

      should "convert string and reflect correct midi note" do
        note = MusicTheory::Note.new("c4")
        assert_equal(60, note.value.number)
      end

      should "convert int and reflect correct midi note" do
        note = MusicTheory::Note.new(55)
        assert_equal note, "G3"
        assert_equal(3, note.octave)
        assert_equal(55, note.value.number)
      end

      should "not reflect midi note when octave is unspecified" do
        note = MusicTheory::Note.new("B")
        assert_nil note.value.number
      end

    end

    context "#mod" do

      context "flat" do

        should "reflect value of accidental" do
          note = MusicTheory::Note.new("Cb5")
          assert_equal(-1, note.value.mod)
        end

      end

      context "double flat" do

        should "reflect value of accidental" do
          note = MusicTheory::Note.new("Dbb4")
          assert_equal(-2, note.value.mod)
        end

      end

      context "sharp" do

        should "reflect value of accidental" do
          note = MusicTheory::Note.new("G#2")
          assert_equal(1, note.value.mod)
        end

      end

      context "double sharp" do

        should "reflect value of accidental" do
          note = MusicTheory::Note.new("G##2")
          assert_equal(2, note.value.mod)
        end

      end

      context "natural" do

        should "reflect no mode for natural" do
          note = MusicTheory::Note.new("B1")
          assert_equal(0, note.value.mod)
        end

      end

    end

  end

end
