require "helper"

class MusicTheory::Note::NameTest < Minitest::Test

  context "Note::Name" do

    context "with octave" do

      context "with accidental" do

        context "with high chars" do

          setup do
            @note = MusicTheory::Note::Name.new("F♯2")
          end

          should "parse octave" do
            assert_equal 2, @note.octave
          end

          should "parse name" do
            assert_equal "F", @note.letter
          end

          should "parse accidental" do
            assert_equal "♯", @note.accidental
          end

          should "match accidental whether high char or not" do
            assert_equal @note, "F♯2"
            assert_equal @note, "F#2"
            refute_equal @note, "F2"
            refute_equal @note, "F##3"
            refute_equal @note, "A3"
          end

        end

        context "without high chars" do

          setup do
            @note = MusicTheory::Note::Name.new("G#3")
          end

          should "parse octave" do
            assert_equal 3, @note.octave
          end

          should "parse name" do
            assert_equal "G", @note.letter
          end

          should "parse accidental" do
            assert_equal "♯", @note.accidental
          end

          should "match accidental whether high char or not" do
            assert_equal @note, "G♯3"
            assert_equal @note, "G#3"
            refute_equal @note, "G3"
            refute_equal @note, "G##3"
            refute_equal @note, "F3"
          end

        end

      end

      context "without accidental" do

        setup do
          @note = MusicTheory::Note::Name.new("E2")
        end

        should "parse octave" do
          assert_equal 2, @note.octave
        end

        should "parse name" do
          assert_equal "E", @note.letter
        end

        should "parse accidental" do
          assert_nil @note.accidental
        end

        should "handle equality" do
          assert_equal @note, "E2"
          assert_equal @note, "e2"
          refute_equal @note, "Eb2"
        end

      end

    end

    context "without octave" do

      context "with accidental" do

        context "with high chars" do

          setup do
            @note = MusicTheory::Note::Name.new("B♭")
          end

          should "parse octave" do
            assert_nil @note.octave
          end

          should "parse name" do
            assert_equal "B", @note.letter
          end

          should "parse accidental" do
            assert_equal "♭", @note.accidental
          end

          should "match accidental whether high char or not" do
            assert_equal @note, "B♭"
            assert_equal @note, "Bb"
            refute_equal @note, "Cb"
            refute_equal @note, "Bb2"
          end

        end

        context "without high chars" do

          setup do
            @note = MusicTheory::Note::Name.new("Eb")
          end

          should "parse octave" do
            assert_nil @note.octave
          end

          should "parse name" do
            assert_equal "E", @note.letter
          end

          should "parse accidental" do
            assert_equal "♭", @note.accidental
          end

          should "match accidental whether high char or not" do
            assert_equal @note, "E♭"
            assert_equal @note, "eb"
            refute_equal @note, "db"
            refute_equal @note, "Bb2"
          end

        end

      end

      context "without accidental" do

        setup do
          @note = MusicTheory::Note::Name.new("F")
        end

        should "parse octave" do
          assert_nil @note.octave
        end

        should "parse name" do
          assert_equal "F", @note.letter
        end

        should "parse accidental" do
          assert_nil @note.accidental
        end

        should "reflect equality" do
          assert_equal @note, "F"
          assert_equal @note, "f"
          refute_equal @note, "eb"
          refute_equal @note, "f#"
        end

      end

    end

  end

end
