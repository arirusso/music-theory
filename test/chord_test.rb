require "helper"

class MusicTheory::ChordTest < Minitest::Test

  context "MusicTheory::Chord" do

    context ".identify" do

      should "identify triad" do
        @chord = MusicTheory::Chord.identify(%w{d f# a})
        assert_equal "DMaj", @chord.name
      end

      should "identify extended" do
        @chord = MusicTheory::Chord.identify(%w{d f# a c#})
        assert_equal "DMaj7", @chord.name
      end

      should "identify inversion" do
        @chord = MusicTheory::Chord.identify(%w{f# a d})
        assert_equal "DMaj", @chord.name
      end

      should "identify across octaves" do
        @chord = MusicTheory::Chord.identify(%w{f#3 a4 d2})
        assert_equal "DMaj", @chord.name
      end

      should "not identify incomplete" do
        @chord = MusicTheory::Chord.identify(%w{f#2 g#2})
        assert_nil @chord.name
      end

      should "not identify chords that aren't in the dictionary" do
        @chord = MusicTheory::Chord.identify(%w{f#2 a5 g#2 b1 bb2})
        assert_nil @chord.name
      end

      should "identify augmented chord" do
        @chord = MusicTheory::Chord.identify(%w{f# a# c##})
        assert_equal "F#Aug", @chord.name
      end

      should "identify symbolic chord" do
        @chord = MusicTheory::Chord.identify(%w{g## b## d##})
        assert_equal "G##Maj", @chord.name
      end

      should "identify with midi notes" do
        @chord = MusicTheory::Chord.identify(64, 67, 71)
        assert_equal "EMin", @chord.name
      end

    end

    context ".name" do

      should "name triad" do
        assert_equal "DMaj", MusicTheory::Chord.name(%w{d f# a})
      end

      should "name extended" do
        assert_equal "DMaj7", MusicTheory::Chord.name(%w{d f# a c#})
      end

      should "name inversion" do
        assert_equal "DMaj", MusicTheory::Chord.name(%w{f# a d})
      end

      should "name across octaves" do
        assert_equal "DMaj", MusicTheory::Chord.name(%w{f#3 a4 d2})
      end

      should "not name incomplete" do
        assert_nil MusicTheory::Chord.name(%w{f#2 g#2})
      end

      should "not name chords that aren't in the dictionary" do
        assert_nil MusicTheory::Chord.name(%w{f#2 a5 g#2 b1 bb2})
      end

      should "name augmented chord" do
        assert_equal "F#Aug", MusicTheory::Chord.name(%w{f# a# c##})
      end

      should "name symbolic chord" do
        assert_equal "G##Maj", MusicTheory::Chord.name(%w{g## b## d##})
      end

      should "name with midi notes" do
        assert_equal "EMin", MusicTheory::Chord.name(64, 67, 71)
      end

    end

  end

end
