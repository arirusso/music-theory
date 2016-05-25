require "helper"

class MusicTheory::Chord::VoicingTest < Minitest::Test

  context "MusicTheory::Chord::Voicing" do

    context ".find_all" do

      context "triad" do

        setup do
          @notes = [
            MusicTheory::Note.new("C"),
            MusicTheory::Note.new("E"),
            MusicTheory::Note.new("G")
          ]
          @voicings = MusicTheory::Chord::Voicing.find_all(:triad, @notes)
        end

        should "populate" do
          refute_nil @voicings
          refute_empty @voicings
          assert_equal 1, @voicings.count
          assert_equal @notes, @voicings.first.members
        end

      end

      context "seventh" do

        setup do
          @notes = [
            MusicTheory::Note.new("E"),
            MusicTheory::Note.new("G#"),
            MusicTheory::Note.new("B"),
            MusicTheory::Note.new("D#")
          ]
          @voicings = MusicTheory::Chord::Voicing.find_all(:seventh, @notes)
        end

        should "populate" do
          refute_nil @voicings
          refute_empty @voicings
          assert_equal 1, @voicings.count
          assert_equal @notes, @voicings.last.members
        end

      end

    end

    context ".match_intervals" do

      setup do
        @notes = [
          MusicTheory::Note.new("E"),
          MusicTheory::Note.new("G#"),
          MusicTheory::Note.new("B"),
        ]
      end

      should "match triad" do
        assert_equal [0, 4, 7], MusicTheory::Chord::Voicing.send(:match_intervals, :triad, :major, @notes)
      end

      should "match seventh" do
        @notes << MusicTheory::Note.new("D#")
        assert_equal [0,4,7,11], MusicTheory::Chord::Voicing.send(:match_intervals, :seventh, :major, @notes)
      end

    end

    context ".get_inversion" do

      should "recognize root inversion" do
        assert_equal 0, MusicTheory::Chord::Voicing.send(:get_inversion, [0, 4, 7], [0, 4, 7])
        assert_equal 0, MusicTheory::Chord::Voicing.send(:get_inversion, [0, 4, 7], [0, 7, 4])
        assert_equal 0, MusicTheory::Chord::Voicing.send(:get_inversion, [0, 4, 7], [0, 7, 4, 11])
        assert_equal 0, MusicTheory::Chord::Voicing.send(:get_inversion, [0, 4, 7], [0, 11, 7, 4])
      end

      should "recognize first inversion" do
        assert_equal 1, MusicTheory::Chord::Voicing.send(:get_inversion, [0, 4, 7], [4, 0, 7])
        assert_equal 1, MusicTheory::Chord::Voicing.send(:get_inversion, [0, 4, 7], [4, 7, 0])
        assert_equal 1, MusicTheory::Chord::Voicing.send(:get_inversion, [0, 4, 7], [4, 7, 0, 11])
        assert_equal 1, MusicTheory::Chord::Voicing.send(:get_inversion, [0, 4, 7], [4, 11, 7, 0])
      end

      should "recognize second inversion" do
        assert_equal 2, MusicTheory::Chord::Voicing.send(:get_inversion, [0, 4, 7], [7, 0, 4])
        assert_equal 2, MusicTheory::Chord::Voicing.send(:get_inversion, [0, 4, 7], [7, 4, 0])
        assert_equal 2, MusicTheory::Chord::Voicing.send(:get_inversion, [0, 4, 7], [7, 0, 4, 11])
        assert_equal 2, MusicTheory::Chord::Voicing.send(:get_inversion, [0, 4, 7], [7, 11, 4, 0])
      end

      should "recognize third inversion" do
        assert_equal 3, MusicTheory::Chord::Voicing.send(:get_inversion, [0, 4, 7, 11], [11, 7, 0, 4])
        assert_equal 3, MusicTheory::Chord::Voicing.send(:get_inversion, [0, 4, 7, 11], [11, 0, 7, 4])
        assert_equal 3, MusicTheory::Chord::Voicing.send(:get_inversion, [0, 4, 7, 11], [11, 4, 7, 0])
        assert_equal 3, MusicTheory::Chord::Voicing.send(:get_inversion, [0, 4, 7, 11], [11, 4, 0, 7])
      end

    end
  end
end
