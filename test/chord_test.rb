require "helper"

class MusicTheory::ChordTest < Minitest::Test

  context "MusicTheory::Chord" do

    context ".identify" do

      should "identify triad" do
        @chord = MusicTheory::Chord.identify(%w{d f# a})
        assert_equal :DMaj, @chord.name
      end

      should "identify extended" do
        MusicTheory::Chord.identify(%w{d f# a c#})
        # > DMaj7
      end

      should "identify inversion" do
        MusicTheory::Chord.identify(%w{f# a d})
        # > DMaj 1st inv
      end

      should "identify across octaves" do
        MusicTheory::Chord.identify(%w{f#3 a4 d2})
        # > DMaj
      end

      should "not identify incomplete" do
        MusicTheory::Chord.identify(%w{f#2 g#2})
        # nil ? or raise ?
      end

    end

  end

end
