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
          @voicings = MusicTheory::Chord::Voicing.find_all(@notes)
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
          @voicings = MusicTheory::Chord::Voicing.find_all(@notes)
        end

        should "populate" do
          refute_nil @voicings
          refute_empty @voicings
          assert_equal 3, @voicings.count
          assert_equal @notes, @voicings.last.members
        end

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
        control = %w{BDim7 A♭Dim7 FDim7 DDim7}
        control.each do |chord|
          assert_includes @chords.map(&:name), chord
        end
        refute @chords.any? { |c| !control.include?(c.name) }
      end

      should "have best guess chord first" do
        assert_equal "BDim7", @chords.first.name
        assert_equal 0, @chords.first.inversion
      end

    end

  end
end
