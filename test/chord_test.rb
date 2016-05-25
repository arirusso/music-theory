require "helper"

class MusicTheory::ChordTest < Minitest::Test

  context "MusicTheory::Chord" do

    context ".identify" do

      should "identify triad" do
        @chord = MusicTheory::Chord.identify(%w{d f# a})
        assert_equal :DMaj, @chord.name
      end

      should "identify extended" do
        @chord = MusicTheory::Chord.identify(%w{d f# a c#})
        assert_equal :DMaj7, @chord.name
      end

      should "identify inversion" do
        @chord = MusicTheory::Chord.identify(%w{f# a d})
        assert_equal :DMaj, @chord.name
      end

      should "identify across octaves" do
        @chord = MusicTheory::Chord.identify(%w{f#3 a4 d2})
        assert_equal :DMaj, @chord.name
      end

      should "not identify incomplete" do
        @chord = MusicTheory::Chord.identify(%w{f#2 g#2})
        assert_nil @chord.name
      end

    end

  end

end
