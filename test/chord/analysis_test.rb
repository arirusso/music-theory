require "helper"

class MusicTheory::Chord::AnalysisTest < Minitest::Test

  context "MusicTheory::Chord::Analysis" do

    context "#root" do

      context "major chord, root inversion" do

        setup do
          @id = MusicTheory::Chord::Voicing.analyze(13,17,19)
        end

        should "reflect correct root" do
          assert_equal 13, @id.root.midi_note_num
        end

      end

      context "major chord, first inversion" do

        setup do
          @id = MusicTheory::Chord::Voicing.analyze(17,13,19)
        end

        should "reflect correct root" do
          assert_equal 13, @id.root.midi_note_num
        end

      end

      context "minor chord, root inversion" do

        setup do
          @id = MusicTheory::Chord::Voicing.analyze(13,16,19)
        end

        should "reflect correct root" do
          assert_equal 13, @id.root.midi_note_num
        end

      end

      context "minor chord, first inversion" do

        setup do
          @id = MusicTheory::Chord::Voicing.analyze(16,13,19)
        end

        should "reflect correct root" do
          assert_equal 13, @id.root.midi_note_num
        end

      end

      context "minor chord, second inversion" do

        setup do
          @id = MusicTheory::Chord::Voicing.analyze(20, 25, 28)
        end

        should "reflect correct root" do
          assert_equal 25, @id.root.midi_note_num
        end
      end

    end

    context "#inversion" do

      context "major chord, root inversion" do

        setup do
          @id = MusicTheory::Chord::Voicing.analyze(13,17,19)
        end

        should "be root inversion" do
          assert_equal 0, @id.inversion
        end

      end

      context "major chord, first inversion" do

        setup do
          @id = MusicTheory::Chord::Voicing.analyze(17,13,19)
        end

        should "be first inversion" do
          assert_equal 1, @id.inversion
        end

      end

      context "minor chord, root inversion" do

        setup do
          @id = MusicTheory::Chord::Voicing.analyze(13,16,19)
        end

        should "be root inversion" do
          assert_equal 0, @id.inversion
        end

      end

      context "minor chord, first inversion" do

        setup do
          @id = MusicTheory::Chord::Voicing.analyze(16,13,19)
        end

        should "be first inversion" do
          assert_equal 1, @id.inversion
        end

      end

      context "minor chord, second inversion" do

        setup do
          @id = MusicTheory::Chord::Voicing.analyze(20, 25, 28)
        end

        should "be second inversion" do
          assert_equal 2, @id.inversion
        end
      end

    end

    context "#has_attribute?" do

      context "major chord, root inversion" do

        setup do
          @id = MusicTheory::Chord::Voicing.analyze(13,17,19)
        end

        should "be major" do
          assert @id.has_attribute?(:major)
        end

      end

      context "major chord, first inversion" do

        setup do
          @id = MusicTheory::Chord::Voicing.analyze(17,13,19)
        end

        should "be major" do
          assert @id.has_attribute?(:major)
        end

      end

      context "minor chord, root inversion" do

        setup do
          @id = MusicTheory::Chord::Voicing.analyze(13,16,19)
        end

        should "be minor" do
          assert @id.has_attribute?(:minor)
        end

      end

      context "minor chord, first inversion" do

        setup do
          @id = MusicTheory::Chord::Voicing.analyze(16,13,19)
        end

        should "be minor" do
          assert @id.has_attribute?(:minor)
        end

      end

      context "minor chord, second inversion" do

        setup do
          @id = MusicTheory::Chord::Voicing.analyze(20, 25, 28)
        end

        should "be minor" do
          assert @id.has_attribute?(:minor)
        end

      end

      context "major seventh" do

        setup do
          @id = MusicTheory::Chord::Voicing.analyze(16,12,18,23)
        end

        should "have major seventh" do
          assert @id.has_attribute?(:major_seventh)
        end

      end

    end

  end

end
