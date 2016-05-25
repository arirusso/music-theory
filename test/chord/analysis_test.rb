require "helper"

class MusicTheory::Chord::AnalysisTest < Minitest::Test

  context "MusicTheory::Chord::Analysis" do

    context "#root" do

      context "major chord, root inversion" do

        setup do
          @id = MusicTheory::Chord::Raw.analyze(13,17,20)
        end

        should "reflect correct root" do
          assert_equal 13, @id.root.midi_note_num
        end

      end

      context "major chord, first inversion" do

        setup do
          @id = MusicTheory::Chord::Raw.analyze(17,13,20)
        end

        should "reflect correct root" do
          assert_equal 13, @id.root.midi_note_num
        end

      end

      context "minor chord, root inversion" do

        setup do
          @id = MusicTheory::Chord::Raw.analyze(13,16,20)
        end

        should "reflect correct root" do
          assert_equal 13, @id.root.midi_note_num
        end

      end

      context "minor chord, first inversion" do

        setup do
          @id = MusicTheory::Chord::Raw.analyze(16,13,20)
        end

        should "reflect correct root" do
          assert_equal 13, @id.root.midi_note_num
        end

      end

      context "minor chord, second inversion" do

        setup do
          @id = MusicTheory::Chord::Raw.analyze(20, 25, 28)
        end

        should "reflect correct root" do
          assert_equal 25, @id.root.midi_note_num
        end
      end

    end

    context "#inversion" do

      context "major chord, root inversion" do

        setup do
          @id = MusicTheory::Chord::Raw.analyze(13,17,20)
        end

        should "be root inversion" do
          assert_equal 0, @id.inversion
        end

      end

      context "major chord, first inversion" do

        setup do
          @id = MusicTheory::Chord::Raw.analyze(17,13,20)
        end

        should "be first inversion" do
          assert_equal 1, @id.inversion
        end

      end

      context "minor chord, root inversion" do

        setup do
          @id = MusicTheory::Chord::Raw.analyze(13,16,20)
        end

        should "be root inversion" do
          assert_equal 0, @id.inversion
        end

      end

      context "minor chord, first inversion" do

        setup do
          @id = MusicTheory::Chord::Raw.analyze(16,13,20)
        end

        should "be first inversion" do
          assert_equal 1, @id.inversion
        end

      end

      context "minor chord, second inversion" do

        setup do
          @id = MusicTheory::Chord::Raw.analyze(20, 25, 28)
        end

        should "be second inversion" do
          assert_equal 2, @id.inversion
        end
      end

    end

    context "#has_triad?" do

      context "major chord, root inversion" do

        setup do
          @id = MusicTheory::Chord::Raw.analyze(13,17,20)
        end

        should "be major" do
          assert @id.includes_triad?(:major)
        end

      end

      context "major chord, first inversion" do

        setup do
          @id = MusicTheory::Chord::Raw.analyze(17,13,20)
        end

        should "be major" do
          assert @id.includes_triad?(:major)
        end

      end

      context "minor chord, root inversion" do

        setup do
          @id = MusicTheory::Chord::Raw.analyze(13,16,20)
        end

        should "be minor" do
          assert @id.includes_triad?(:minor)
        end

      end

      context "minor chord, first inversion" do

        setup do
          @id = MusicTheory::Chord::Raw.analyze(16,13,20)
        end

        should "be minor" do
          assert @id.includes_triad?(:minor)
        end

      end

      context "minor chord, second inversion" do

        setup do
          @id = MusicTheory::Chord::Raw.analyze(20, 25, 28)
        end

        should "be minor" do
          assert @id.includes_triad?(:minor)
        end

      end

      context "major seventh" do

        setup do
          @id = MusicTheory::Chord::Raw.analyze(16,12,19,23)
        end

        should "have major triad" do
          assert @id.includes_triad?(:major)
        end

      end

    end

    context "#includes_seventh_chord?" do

      context "major chord, root inversion" do

        setup do
          @id = MusicTheory::Chord::Raw.analyze(13,17,20)
        end

        should "not have seventh" do
          refute @id.includes_seventh_chord?(:major)
        end

      end

      context "major seventh" do

        setup do
          @id = MusicTheory::Chord::Raw.analyze(16,12,19,23)
        end

        should "have major triad" do
          assert @id.includes_seventh_chord?(:major)
        end

      end

    end

    context "#is_chord" do

      context "major chord, root inversion" do

        setup do
          @id = MusicTheory::Chord::Raw.analyze(13,17,20)
          @chord = @id.is_chord
        end

        should "be assigned" do
          refute_nil @chord
        end

        should "have correct root" do
          assert_equal 13, @chord.root.midi_note_num
        end

        should "have correct inversion" do
          assert_equal 0, @chord.inversion
        end

      end

      context "major chord, first inversion" do

        setup do
          @id = MusicTheory::Chord::Raw.analyze(17,13,20)
          @chord = @id.is_chord
        end

        should "be assigned" do
          refute_nil @chord
        end

        should "have correct root" do
          assert_equal 13, @chord.root.midi_note_num
        end

        should "have correct inversion" do
          assert_equal 1, @chord.inversion
        end

      end

      context "minor chord, root inversion" do

        setup do
          @id = MusicTheory::Chord::Raw.analyze(13,16,20)
          @chord = @id.is_chord
        end

        should "be assigned" do
          refute_nil @chord
        end

        should "have correct root" do
          assert_equal 13, @chord.root.midi_note_num
        end

        should "have correct inversion" do
          assert_equal 0, @chord.inversion
        end

      end

      context "minor chord, first inversion" do

        setup do
          @id = MusicTheory::Chord::Raw.analyze(16,13,20)
          @chord = @id.is_chord
        end

        should "be assigned" do
          refute_nil @chord
        end

        should "have correct root" do
          assert_equal 13, @chord.root.midi_note_num
        end

        should "have correct inversion" do
          assert_equal 1, @chord.inversion
        end

      end

      context "minor chord, second inversion" do

        setup do
          @id = MusicTheory::Chord::Raw.analyze(20, 25, 28)
          @chord = @id.is_chord
        end

        should "be assigned" do
          refute_nil @chord
        end

        should "have correct root" do
          assert_equal 25, @chord.root.midi_note_num
        end

        should "have correct inversion" do
          assert_equal 2, @chord.inversion
        end

      end

      context "major seventh" do

        setup do
          @id = MusicTheory::Chord::Raw.analyze(16,12,19,23)
          @chord = @id.is_chord
        end

        should "be assigned" do
          refute_nil @chord
        end

        should "have seventh chord" do
          assert @chord.seventh?
          assert_equal 4, @chord.members.size
        end

        should "have correct root" do
          assert_equal 12, @chord.root.midi_note_num
        end

        should "have correct inversion" do
          assert_equal 1, @chord.inversion
        end

      end

    end

  end

end
