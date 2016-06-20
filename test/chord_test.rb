require "helper"

class MusicTheory::ChordTest < Minitest::Test

  context "MusicTheory::Chord" do

    context ".identify" do

      context "triad" do

        context "major" do

          should "identify using note names" do
            @chord = MusicTheory::Chord.identify(%w{d f# a})
            assert_equal "DMaj", @chord.name
          end

          should "identify using note names when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{f# a d})
            assert_equal "DMaj", @chord.name
          end

          should "identify using note names when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{a f# d})
            assert_equal "DMaj", @chord.name
          end

          should "identify using note names + octaves when across octaves" do
            @chord = MusicTheory::Chord.identify(%w{f#3 a4 d2})
            assert_equal "DMaj", @chord.name
          end

          should "identify symbolic chord using note names" do
            @chord = MusicTheory::Chord.identify(%w{g## b## d##})
            assert_equal "G##Maj", @chord.name
          end

        end

        context "minor" do

          should "identify using note names" do
            @chord = MusicTheory::Chord.identify(%w{a c e})
            assert_equal "AMin", @chord.name
          end

          should "identify using note names when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{c a e})
            assert_equal "AMin", @chord.name
          end

          should "identify using note names when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{e c a})
            assert_equal "AMin", @chord.name
          end

          should "identify using midi notes" do
            @chord = MusicTheory::Chord.identify(64, 67, 71)
            assert_equal "EMin", @chord.name
          end

        end

        context "diminished" do

          should "identify using note names" do
            @chord = MusicTheory::Chord.identify(%w{b d f})
            assert_equal "BDim", @chord.name
          end

          should "identify using note names when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{d b f})
            assert_equal "BDim", @chord.name
          end

          should "identify using note names when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{f d b})
            assert_equal "BDim", @chord.name
          end

        end

        context "augmented" do

          should "identify using note names" do
            @chord = MusicTheory::Chord.identify(%w{f# a# c##})
            assert_equal "F#Aug", @chord.name
          end

          should "not identify first inversion" do
            @chord = MusicTheory::Chord.identify(%w{a# c## f#})
            refute_equal "F#Aug", @chord.name
          end

          should "not identify second inversion" do
            @chord = MusicTheory::Chord.identify(%w{c## f# a#})
            refute_equal "F#Aug", @chord.name
          end

        end

      end

      context "seventh" do

        context "major" do

          should "identify using note names" do
            @chord = MusicTheory::Chord.identify(%w{d f# a c#})
            assert_equal "DMaj7", @chord.name
          end

          should "identify using note names when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{f# a c# d})
            assert_equal "DMaj7", @chord.name
          end

          should "identify using note names when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{a f# c# d})
            assert_equal "DMaj7", @chord.name
          end

        end

        context "minor" do

          should "identify using note names" do
            @chord = MusicTheory::Chord.identify(%w{c eb g bb})
            assert_equal "CMin7", @chord.name
          end

          should "identify using note names when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{eb g bb c})
            assert_equal "CMin7", @chord.name
          end

          should "identify using note names when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{g eb bb c})
            assert_equal "CMin7", @chord.name
          end

          should "identify across octaves" do
            @chord = MusicTheory::Chord.identify(%w{c1 eb1 g2 bb3})
            assert_equal "CMin7", @chord.name
          end

          should "identify across octaves when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{eb1 g2 bb2 c3})
            assert_equal "CMin7", @chord.name
          end

        end

        context "dominant" do

          should "identify using note names" do
            @chord = MusicTheory::Chord.identify(%w{f a c eb})
            assert_equal "F7", @chord.name
          end

          should "identify using note names when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{a c f eb})
            assert_equal "F7", @chord.name
          end

          should "identify using note names when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{c a f eb})
            assert_equal "F7", @chord.name
          end

        end

        context "augmented" do

          should "identify using note names" do
            @chord = MusicTheory::Chord.identify(%w{e g# b# d})
            assert_equal "EAug7", @chord.name
          end

          should "identify using note names when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{g# b# d e})
            assert_equal "EAug7", @chord.name
          end

          should "identify using note names when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{b# g# d e})
            assert_equal "EAug7", @chord.name
          end

        end

        context "diminished" do

          should "identify using note names" do
            @chord = MusicTheory::Chord.identify(%w{b d f ab})
            assert_equal "BDim7", @chord.name
          end

          should "not identify when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{d f b ab})
            refute_equal "BDim7", @chord.name
          end

          should "not identify when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{f d b ab})
            refute_equal "BDim7", @chord.name
          end

        end

        context "half diminished" do

          should "identify using note names" do
            @chord = MusicTheory::Chord.identify(%w{b d f a})
            assert_equal "Bm7♭5", @chord.name
          end

          should "identify using note names when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{d f b a})
            assert_equal "Bm7♭5", @chord.name
          end

          should "identify using note names when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{f d b a})
            assert_equal "Bm7♭5", @chord.name
          end

        end

      end

      context "ninth" do

        context "major" do

          should "identify from midi notes" do
            @chord = MusicTheory::Chord.identify(64, 68, 71, 75, 78)
            assert_equal "EMaj9", @chord.name
          end

          should "identify from midi notes when in first inversion" do
            @chord = MusicTheory::Chord.identify(68, 71, 75, 76, 78)
            assert_equal "EMaj9", @chord.name
          end

          should "identify from midi notes when in second inversion" do
            @chord = MusicTheory::Chord.identify(71, 75, 76, 78, 80)
            assert_equal "EMaj9", @chord.name
          end

          should "identify using note names" do
            @chord = MusicTheory::Chord.identify(%w{d f# a c# e})
            assert_equal "DMaj9", @chord.name
          end

          should "identify across octaves" do
            @chord = MusicTheory::Chord.identify(%w{d1 f#2 a3 c#4 e5})
            assert_equal "DMaj9", @chord.name
          end

          should "identify using note names when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{f# a c# d e})
            assert_equal "DMaj9", @chord.name
          end

          should "identify using note names when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{a f# c# d e})
            assert_equal "DMaj9", @chord.name
          end

          should "identify across octaves when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{f#1 a2 c#3 d4 e5})
            assert_equal "DMaj9", @chord.name
          end

          should "identify across octaves when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{a1 f#2 c#3 d4 e5})
            assert_equal "DMaj9", @chord.name
          end

        end

        context "minor" do

          should "identify from midi notes" do
            @chord = MusicTheory::Chord.identify(64, 67, 71, 74, 78)
            assert_equal "EMin9", @chord.name
          end

          should "identify from midi notes when in first inversion" do
            @chord = MusicTheory::Chord.identify(67, 71, 74, 76, 78)
            assert_equal "EMin9", @chord.name
          end

          should "identify from midi notes when in second inversion" do
            @chord = MusicTheory::Chord.identify(71, 74, 76, 78, 79)
            assert_equal "EMin9", @chord.name
          end

          should "identify using note names" do
            @chord = MusicTheory::Chord.identify(%w{g bb d f a})
            assert_equal "GMin9", @chord.name
          end

          should "identify across octaves" do
            @chord = MusicTheory::Chord.identify(%w{g1 bb2 d3 f4 a5})
            assert_equal "GMin9", @chord.name
          end

          should "identify using note names when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{bb d f a g})
            assert_equal "GMin9", @chord.name
          end

          should "identify using note names when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{d f g bb a})
            assert_equal "GMin9", @chord.name
          end

          should "identify across octaves when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{f#1 a2 c#3 d4 e5})
            assert_equal "DMaj9", @chord.name
          end

          should "identify across octaves when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{a1 f#2 c#3 d4 e5})
            assert_equal "DMaj9", @chord.name
          end

        end

      end

      context "not identifiable" do

        should "not identify incomplete" do
          @chord = MusicTheory::Chord.identify(%w{f#2 g#2})
          assert_nil @chord.name
        end

        should "not identify chords that aren't in the dictionary" do
          @chord = MusicTheory::Chord.identify(%w{f#2 a5 g#2 b1 bb2})
          assert_nil @chord.name
        end

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
