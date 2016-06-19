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

    context ".as_intervals" do

      setup do
        @notes = [
          MusicTheory::Note.new("E"),
          MusicTheory::Note.new("G#"),
          MusicTheory::Note.new("B"),
        ]
      end

      should "match triad" do
        assert_includes MusicTheory::Chord::Voicing.send(:as_intervals, :triad, :major, @notes), [0, 4, 7]
      end

      should "match seventh" do
        @notes << MusicTheory::Note.new("D#")
        assert_includes MusicTheory::Chord::Voicing.send(:as_intervals, :seventh, :major, @notes), [0,4,7,11]
      end

    end

    context "#chords_by_precedence" do

      setup do
        @chord = MusicTheory::Chord.identify(%w{b d f ab})
        @chords = @chord.send(:chords_by_precedence)
      end

      should "return collection of chords" do
        refute_nil @chords
        refute_empty @chords
        assert @chords.all? { |c| c.kind_of?(MusicTheory::Chord::Voicing) }
      end

      should "contain all included chords" do

      end

      should "have best guess chord first" do

      end

    end

  end
end
