require "helper"

class MusicTheory::Chord::AnalysisTest < Minitest::Test

  context "MusicTheory::Chord::Analysis" do

    context "#get_inversion" do

      setup do
        # use this to get access to the method
        @id = MusicTheory::Chord::Voicing.analyze(13,17,20)
      end

      should "recognize root inversion" do
        assert_equal 0, @id.send(:get_inversion, [0, 4, 7], [0, 4, 7])
        assert_equal 0, @id.send(:get_inversion, [0, 4, 7], [0, 7, 4])
        assert_equal 0, @id.send(:get_inversion, [0, 4, 7], [0, 7, 4, 11])
        assert_equal 0, @id.send(:get_inversion, [0, 4, 7], [0, 11, 7, 4])
      end

      should "recognize first inversion" do
        assert_equal 1, @id.send(:get_inversion, [0, 4, 7], [4, 0, 7])
        assert_equal 1, @id.send(:get_inversion, [0, 4, 7], [4, 7, 0])
        assert_equal 1, @id.send(:get_inversion, [0, 4, 7], [4, 7, 0, 11])
        assert_equal 1, @id.send(:get_inversion, [0, 4, 7], [4, 11, 7, 0])
      end

      should "recognize second inversion" do
        assert_equal 2, @id.send(:get_inversion, [0, 4, 7], [7, 0, 4])
        assert_equal 2, @id.send(:get_inversion, [0, 4, 7], [7, 4, 0])
        assert_equal 2, @id.send(:get_inversion, [0, 4, 7], [7, 0, 4, 11])
        assert_equal 2, @id.send(:get_inversion, [0, 4, 7], [7, 11, 4, 0])
      end

      should "recognize third inversion" do
        assert_equal 3, @id.send(:get_inversion, [0, 4, 7, 11], [11, 7, 0, 4])
        assert_equal 3, @id.send(:get_inversion, [0, 4, 7, 11], [11, 0, 7, 4])
        assert_equal 3, @id.send(:get_inversion, [0, 4, 7, 11], [11, 4, 7, 0])
        assert_equal 3, @id.send(:get_inversion, [0, 4, 7, 11], [11, 4, 0, 7])
      end

    end

    context "#root" do

      context "major chord, root inversion" do

        setup do
          @id = MusicTheory::Chord::Voicing.analyze(13,17,20)
        end

        should "reflect correct root" do
          assert_equal 13, @id.root.midi_note_num
        end

      end

      context "major chord, first inversion" do

        setup do
          @id = MusicTheory::Chord::Voicing.analyze(17,13,20)
        end

        should "reflect correct root" do
          assert_equal 13, @id.root.midi_note_num
        end

      end

      context "minor chord, root inversion" do

        setup do
          @id = MusicTheory::Chord::Voicing.analyze(13,16,20)
        end

        should "reflect correct root" do
          assert_equal 13, @id.root.midi_note_num
        end

      end

      context "minor chord, first inversion" do

        setup do
          @id = MusicTheory::Chord::Voicing.analyze(16,13,20)
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

    context "#has_triad?" do

      context "major chord, root inversion" do

        setup do
          @id = MusicTheory::Chord::Voicing.analyze(13,17,20)
        end

        should "be major" do
          assert @id.has_triad?(:major)
        end

      end

      context "major chord, first inversion" do

        setup do
          @id = MusicTheory::Chord::Voicing.analyze(17,13,20)
        end

        should "be major" do
          assert @id.has_triad?(:major)
        end

      end

      context "minor chord, root inversion" do

        setup do
          @id = MusicTheory::Chord::Voicing.analyze(13,16,20)
        end

        should "be minor" do
          assert @id.has_triad?(:minor)
        end

      end

      context "minor chord, first inversion" do

        setup do
          @id = MusicTheory::Chord::Voicing.analyze(16,13,20)
        end

        should "be minor" do
          assert @id.has_triad?(:minor)
        end

      end

      context "minor chord, second inversion" do

        setup do
          @id = MusicTheory::Chord::Voicing.analyze(20, 25, 28)
        end

        should "be minor" do
          assert @id.has_triad?(:minor)
        end

      end

      context "major seventh" do

        setup do
          @id = MusicTheory::Chord::Voicing.analyze(16,12,19,23)
        end

        should "have major triad" do
          assert @id.has_triad?(:major)
        end

      end

    end

  end

end
