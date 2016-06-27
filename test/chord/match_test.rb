require "helper"

class MusicTheory::Chord::MatchTest < Minitest::Test

  context "MusicTheory::Chord::Match" do

    context ".interval_permutations" do

      setup do
        @notes = [
          MusicTheory::Note.new("E"),
          MusicTheory::Note.new("G#"),
          MusicTheory::Note.new("B"),
        ]
      end

      should "match triad" do
        type = :triad
        name = :major
        dictionary = MusicTheory::Chord::DICTIONARY[type][name]
        assert_includes MusicTheory::Chord::Match.send(:interval_permutations, dictionary, @notes), [0, 4, 7]
      end

      should "match seventh" do
        type = :seventh
        name = :major
        dictionary = MusicTheory::Chord::DICTIONARY[type][name]
        @notes << MusicTheory::Note.new("D#")
        assert_includes MusicTheory::Chord::Match.send(:interval_permutations, dictionary, @notes), [0,4,7,11]
      end

    end

  end
end
