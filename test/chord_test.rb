require "helper"

class MusicTheory::ChordTest < Minitest::Test

  context "MusicTheory::Chord" do

    context ".identify" do

      context "triad" do

        context "major" do

          should "identify using note names" do
            @chord = MusicTheory::Chord.identify(%w{d f# a})
            assert_equal "DMaj", @chord.name
            assert_equal 0, @chord.inversion
          end

          should "identify using note names when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{f# a d})
            assert_equal "DMaj", @chord.name
            assert_equal 1, @chord.inversion
          end

          should "identify using note names when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{a f# d})
            assert_equal "DMaj", @chord.name
            assert_equal 2, @chord.inversion
          end

          should "identify using note names when across octaves" do
            @chord = MusicTheory::Chord.identify(%w{f#3 a4 d2})
            assert_equal "DMaj", @chord.name
            assert_equal 1, @chord.inversion
          end

          should "identify symbolic chord using note names" do
            @chord = MusicTheory::Chord.identify(%w{g## b## d##})
            assert_equal "G♯♯Maj", @chord.name
            assert_equal 0, @chord.inversion
          end

          should "identify when there are duplicate notes" do
            @chord = MusicTheory::Chord.identify(%w{f#1 a2 d2 a3 d3})
            assert_equal "DMaj", @chord.name
            assert_equal 1, @chord.inversion
          end

        end

        context "minor" do

          should "identify using note names" do
            @chord = MusicTheory::Chord.identify(%w{a c e})
            assert_equal "AMin", @chord.name
            assert_equal 0, @chord.inversion
          end

          should "identify using note names when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{c a e})
            assert_equal "AMin", @chord.name
            assert_equal 1, @chord.inversion
          end

          should "identify using note names when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{e c a})
            assert_equal "AMin", @chord.name
            assert_equal 2, @chord.inversion
          end

          should "identify when there are dup notes" do
            @chord = MusicTheory::Chord.identify(%w{b1 d2 f#2 b3})
            assert_equal "BMin", @chord.name
            assert_equal 0, @chord.inversion
          end

          should "identify using midi notes" do
            @chord = MusicTheory::Chord.identify(64, 67, 71)
            assert_equal "EMin", @chord.name
            assert_equal 0, @chord.inversion
          end

        end

        context "diminished" do

          should "identify using note names" do
            @chord = MusicTheory::Chord.identify(%w{b d f})
            assert_equal "BDim", @chord.name
            assert_equal 0, @chord.inversion
          end

          should "identify using note names when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{d b f})
            assert_equal "BDim", @chord.name
            assert_equal 1, @chord.inversion
          end

          should "identify using note names when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{f d b})
            assert_equal "BDim", @chord.name
            assert_equal 2, @chord.inversion
          end

          should "identify when there are dup notes" do
            @chord = MusicTheory::Chord.identify(%w{c1 eb2 gb2 eb4})
            assert_equal "CDim", @chord.name
            assert_equal 0, @chord.inversion
          end

        end

        context "augmented" do

          should "identify using note names" do
            @chord = MusicTheory::Chord.identify(%w{f# a# c##})
            assert_equal "F♯Aug", @chord.name
            assert_equal 0, @chord.inversion
          end

          should "not identify first inversion" do
            @chord = MusicTheory::Chord.identify(%w{a# c## f#})
            refute_equal "F♯Aug", @chord.name
            refute_equal 1, @chord.inversion
          end

          should "not identify second inversion" do
            @chord = MusicTheory::Chord.identify(%w{c## f# a#})
            refute_equal "F♯Aug", @chord.name
            refute_equal 1, @chord.inversion
          end

          should "identify when there are dup notes" do
            @chord = MusicTheory::Chord.identify(%w{g1 d#1 b2 b3 b4 d#5})
            assert_equal "GAug", @chord.name
            assert_equal 0, @chord.inversion
          end

        end

      end

      context "seventh" do

        context "major" do

          should "identify using note names" do
            @chord = MusicTheory::Chord.identify(%w{d f# a c#})
            assert_equal "DMaj7", @chord.name
            assert_equal 0, @chord.inversion
          end

          should "identify using note names when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{f# a c# d})
            assert_equal "DMaj7", @chord.name
            assert_equal 1, @chord.inversion
          end

          should "identify using note names when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{a f# c# d})
            assert_equal "DMaj7", @chord.name
            assert_equal 2, @chord.inversion
          end

          should "identify using note names when in third inversion" do
            @chord = MusicTheory::Chord.identify(%w{c# a f# d})
            assert_equal "DMaj7", @chord.name
            assert_equal 3, @chord.inversion
          end

          should "identify when there are dup notes" do
            @chord = MusicTheory::Chord.identify(%w{e1 c2 g2 b3 c4 b5})
            assert_equal "CMaj7", @chord.name
            assert_equal 1, @chord.inversion
          end

        end

        context "minor" do

          should "identify using note names" do
            @chord = MusicTheory::Chord.identify(%w{c eb g bb})
            assert_equal "CMin7", @chord.name
            assert_equal 0, @chord.inversion
          end

          should "identify using note names when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{eb g bb c})
            assert_equal "CMin7", @chord.name
            assert_equal 1, @chord.inversion
          end

          should "identify using note names when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{g eb bb c})
            assert_equal "CMin7", @chord.name
            assert_equal 2, @chord.inversion
          end

          should "identify using note names when in third inversion" do
            @chord = MusicTheory::Chord.identify(%w{bb g eb c})
            assert_equal "CMin7", @chord.name
            assert_equal 3, @chord.inversion
          end

          should "identify across octaves" do
            @chord = MusicTheory::Chord.identify(%w{c1 eb1 g2 bb3})
            assert_equal "CMin7", @chord.name
            assert_equal 0, @chord.inversion
          end

          should "identify across octaves when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{eb1 g2 bb2 c3})
            assert_equal "CMin7", @chord.name
            assert_equal 1, @chord.inversion
          end

          should "identify across octaves when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{g1 eb2 bb3 c4})
            assert_equal "CMin7", @chord.name
            assert_equal 2, @chord.inversion
          end

          should "identify across octaves when in third inversion" do
            @chord = MusicTheory::Chord.identify(%w{bb1 g2 eb2 c4})
            assert_equal "CMin7", @chord.name
            assert_equal 3, @chord.inversion
          end

          should "identify when there are dup notes" do
            @chord = MusicTheory::Chord.identify(%w{bb1 g2 eb2 c4 eb4 c4 c3 bb2})
            assert_equal "CMin7", @chord.name
            assert_equal 3, @chord.inversion
          end

        end

        context "dominant" do

          should "identify using note names" do
            @chord = MusicTheory::Chord.identify(%w{f a c eb})
            assert_equal "F7", @chord.name
            assert_equal 0, @chord.inversion
          end

          should "identify using note names when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{a c f eb})
            assert_equal "F7", @chord.name
            assert_equal 1, @chord.inversion
          end

          should "identify using note names when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{c a f eb})
            assert_equal "F7", @chord.name
            assert_equal 2, @chord.inversion
          end

          should "identify using note names when in third inversion" do
            @chord = MusicTheory::Chord.identify(%w{eb c a f})
            assert_equal "F7", @chord.name
            assert_equal 3, @chord.inversion
          end

          should "identify when there are dup notes" do
            @chord = MusicTheory::Chord.identify(%w{c1 a2 f2 eb3 a4 f5})
            assert_equal "F7", @chord.name
            assert_equal 2, @chord.inversion
          end

        end

        context "augmented" do

          should "identify using note names" do
            @chord = MusicTheory::Chord.identify(%w{e g# b# d})
            assert_equal "EAug7", @chord.name
            assert_equal 0, @chord.inversion
          end

          should "identify using note names when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{g# b# d e})
            assert_equal "EAug7", @chord.name
            assert_equal 1, @chord.inversion
          end

          should "identify using note names when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{b# g# d e})
            assert_equal "EAug7", @chord.name
            assert_equal 2, @chord.inversion
          end

          should "identify using note names when in third inversion" do
            @chord = MusicTheory::Chord.identify(%w{d b# g# e})
            assert_equal "EAug7", @chord.name
            assert_equal 3, @chord.inversion
          end

          should "identify when there are dup notes" do
            @chord = MusicTheory::Chord.identify(%w{b#1 g#2 d2 e3 d2 g#1})
            assert_equal "EAug7", @chord.name
            assert_equal 2, @chord.inversion
          end

        end

        context "diminished" do

          should "identify using note names" do
            @chord = MusicTheory::Chord.identify(%w{b d f ab})
            assert_equal "BDim7", @chord.name
            assert_equal 0, @chord.inversion
          end

          should "not identify when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{d f b ab})
            refute_equal "BDim7", @chord.name
            refute_equal 1, @chord.inversion
          end

          should "not identify when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{f d b ab})
            refute_equal "BDim7", @chord.name
            refute_equal 2, @chord.inversion
          end

          should "not identify when in third inversion" do
            @chord = MusicTheory::Chord.identify(%w{ab f d b})
            refute_equal "BDim7", @chord.name
            refute_equal 3, @chord.inversion
          end

          should "identify when there are dup notes" do
            @chord = MusicTheory::Chord.identify(%w{b1 d2 f2 ab2 d3 f4})
            assert_equal "BDim7", @chord.name
            assert_equal 0, @chord.inversion
          end

        end

        context "half diminished" do

          should "identify using note names" do
            @chord = MusicTheory::Chord.identify(%w{b d f a})
            assert_equal "Bm7♭5", @chord.name
            assert_equal 0, @chord.inversion
          end

          should "identify using note names when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{d f b a})
            assert_equal "Bm7♭5", @chord.name
            assert_equal 1, @chord.inversion
          end

          should "identify using note names when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{f d b a})
            assert_equal "Bm7♭5", @chord.name
            assert_equal 2, @chord.inversion
          end

          should "identify using note names when in third inversion" do
            @chord = MusicTheory::Chord.identify(%w{a f d b})
            assert_equal "Bm7♭5", @chord.name
            assert_equal 3, @chord.inversion
          end

          should "identify when there are dup notes" do
            @chord = MusicTheory::Chord.identify(%w{a1 f1 d2 b2 d3 b3 a4})
            assert_equal "Bm7♭5", @chord.name
            assert_equal 3, @chord.inversion
          end

        end

      end

      context "ninth" do

        context "major" do

          should "identify from midi notes" do
            @chord = MusicTheory::Chord.identify(64, 68, 71, 75, 78)
            assert_equal "EMaj9", @chord.name
            assert_equal 0, @chord.inversion
          end

          should "identify from midi notes when in first inversion" do
            @chord = MusicTheory::Chord.identify(68, 71, 75, 76, 90)
            assert_equal "EMaj9", @chord.name
            assert_equal 1, @chord.inversion
          end

          should "identify from midi notes when in second inversion" do
            @chord = MusicTheory::Chord.identify(71, 75, 76, 80, 90)
            assert_equal "EMaj9", @chord.name
            assert_equal 2, @chord.inversion
          end

          should "identify from midi notes when in third inversion" do
            @chord = MusicTheory::Chord.identify(75, 76, 80, 83, 90)
            assert_equal "EMaj9", @chord.name
            assert_equal 3, @chord.inversion
          end

          should "identify using note names" do
            @chord = MusicTheory::Chord.identify(%w{d f# a c# e})
            assert_equal "DMaj9", @chord.name
            assert_equal 0, @chord.inversion
          end

          should "identify across octaves" do
            @chord = MusicTheory::Chord.identify(%w{d1 f#2 a3 c#4 e5})
            assert_equal "DMaj9", @chord.name
            assert_equal 0, @chord.inversion
          end

          should "identify using note names when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{f# a c# d e})
            assert_equal "DMaj9", @chord.name
            assert_equal 1, @chord.inversion
          end

          should "identify using note names when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{a f# c# d e})
            assert_equal "DMaj9", @chord.name
            assert_equal 2, @chord.inversion
          end

          should "identify using note names when in third inversion" do
            @chord = MusicTheory::Chord.identify(%w{c# a f# d e})
            assert_equal "DMaj9", @chord.name
            assert_equal 3, @chord.inversion
          end

          should "identify across octaves when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{f♯1 a2 c♯3 d4 e5})
            assert_equal "DMaj9", @chord.name
            assert_equal 1, @chord.inversion
          end

          should "identify across octaves when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{a1 f#2 c#3 d4 e5})
            assert_equal "DMaj9", @chord.name
            assert_equal 2, @chord.inversion
          end

          should "identify across octaves when in third inversion" do
            @chord = MusicTheory::Chord.identify(%w{c#1 a1 f#2 d3 e4})
            assert_equal "DMaj9", @chord.name
            assert_equal 3, @chord.inversion
          end

          should "identify when there are dup notes" do
            @chord = MusicTheory::Chord.identify(%w{a1 f#2 c#3 d4 e5 a1 f#2 f#5 d5})
            assert_equal "DMaj9", @chord.name
            assert_equal 2, @chord.inversion
          end

        end

        context "minor" do

          should "identify from midi notes" do
            @chord = MusicTheory::Chord.identify(64, 67, 71, 74, 78)
            assert_equal "EMin9", @chord.name
            assert_equal 0, @chord.inversion
          end

          should "identify from midi notes when in first inversion" do
            @chord = MusicTheory::Chord.identify(67, 71, 74, 76, 90)
            assert_equal "EMin9", @chord.name
            assert_equal 1, @chord.inversion
          end

          should "identify from midi notes when in second inversion" do
            @chord = MusicTheory::Chord.identify(71, 74, 76, 79, 90)
            assert_equal "EMin9", @chord.name
            assert_equal 2, @chord.inversion
          end

          should "identify from midi notes when in third inversion" do
            @chord = MusicTheory::Chord.identify(74, 76, 79, 83, 90)
            assert_equal "EMin9", @chord.name
            assert_equal 3, @chord.inversion
          end

          should "identify using note names" do
            @chord = MusicTheory::Chord.identify(%w{g bb d f a})
            assert_equal "GMin9", @chord.name
            assert_equal 0, @chord.inversion
          end

          should "identify across octaves" do
            @chord = MusicTheory::Chord.identify(%w{g1 bb2 d3 f4 a5})
            assert_equal "GMin9", @chord.name
            assert_equal 0, @chord.inversion
          end

          should "identify using note names when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{bb d f a g})
            assert_equal "GMin9", @chord.name
            assert_equal 1, @chord.inversion
          end

          should "identify using note names when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{d f g bb a})
            assert_equal "GMin9", @chord.name
            assert_equal 2, @chord.inversion
          end

          should "identify using note names when in third inversion" do
            @chord = MusicTheory::Chord.identify(%w{f d g bb a})
            assert_equal "GMin9", @chord.name
            assert_equal 3, @chord.inversion
          end

          should "identify across octaves when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{f1 a2 c3 d4 e5})
            assert_equal "DMin9", @chord.name
            assert_equal 1, @chord.inversion
          end

          should "identify across octaves when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{a1 f2 c3 d4 e5})
            assert_equal "DMin9", @chord.name
            assert_equal 2, @chord.inversion
          end

          should "identify across octaves when in third inversion" do
            @chord = MusicTheory::Chord.identify(%w{c1 a2 f2 d3 e4})
            assert_equal "DMin9", @chord.name
            assert_equal 3, @chord.inversion
          end

          should "identify when there are dup notes" do
            @chord = MusicTheory::Chord.identify(%w{f1 f2 a2 c3 d4 e5 f5 d5})
            assert_equal "DMin9", @chord.name
            assert_equal 1, @chord.inversion
          end

          should "not identify when there are extraneous notes" do
            @chord = MusicTheory::Chord.identify(%w{f1 f2 bb3 a2 c3 d4 e5 f5 d5})
            refute_equal "DMin9", @chord.name
          end

        end

        context "dominant" do

          should "identify using note names" do
            @chord = MusicTheory::Chord.identify(%w{d f# a c e})
            assert_equal "D9", @chord.name
            assert_equal 0, @chord.inversion
          end

          should "identify using note names when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{f# a c d e})
            assert_equal "D9", @chord.name
            assert_equal 1, @chord.inversion
          end

          should "identify using note names when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{a f# c d e})
            assert_equal "D9", @chord.name
            assert_equal 2, @chord.inversion
          end

          should "identify using note names when in third inversion" do
            @chord = MusicTheory::Chord.identify(%w{c a f# d e})
            assert_equal "D9", @chord.name
            assert_equal 3, @chord.inversion
          end

          should "identify across octaves" do
            @chord = MusicTheory::Chord.identify(%w{d1 f#2 a3 c4 e5})
            assert_equal "D9", @chord.name
            assert_equal 0, @chord.inversion
          end

          should "identify across octaves when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{f♯1 a2 c3 d4 e5})
            assert_equal "D9", @chord.name
            assert_equal 1, @chord.inversion
          end

          should "identify across octaves when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{a1 f#2 c3 d4 e5})
            assert_equal "D9", @chord.name
            assert_equal 2, @chord.inversion
          end

          should "identify across octaves when in third inversion" do
            @chord = MusicTheory::Chord.identify(%w{c1 a1 f#2 d3 e4})
            assert_equal "D9", @chord.name
            assert_equal 3, @chord.inversion
          end

          should "identify when there are dup notes" do
            @chord = MusicTheory::Chord.identify(%w{a1 f#2 c3 d4 e5 a1 f#2 f#5 d5})
            assert_equal "D9", @chord.name
            assert_equal 2, @chord.inversion
          end

          should "identify when fifth is omitted" do
            @chord = MusicTheory::Chord.identify(%w{d1 f#2 c4 e5})
            assert_equal "D9", @chord.name
            assert_equal 0, @chord.inversion
          end

        end

        context "add" do

          should "identify using note names" do
            @chord = MusicTheory::Chord.identify(%w{d f# a e})
            assert_equal "DAdd9", @chord.name
            assert_equal 0, @chord.inversion
          end

          should "identify using note names when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{f# a d e})
            assert_equal "DAdd9", @chord.name
            assert_equal 1, @chord.inversion
          end

          should "identify using note names when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{a f# d e})
            assert_equal "DAdd9", @chord.name
            assert_equal 2, @chord.inversion
          end

          should "identify across octaves" do
            @chord = MusicTheory::Chord.identify(%w{d1 f#2 a3 e4})
            assert_equal "DAdd9", @chord.name
            assert_equal 0, @chord.inversion
          end

          should "identify across octaves when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{f♯1 a2 d3 e4})
            assert_equal "DAdd9", @chord.name
            assert_equal 1, @chord.inversion
          end

          should "identify across octaves when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{a1 f#2 d3 e4})
            assert_equal "DAdd9", @chord.name
            assert_equal 2, @chord.inversion
          end

          should "identify when there are dup notes" do
            @chord = MusicTheory::Chord.identify(%w{a1 d1 e2 f#2 a1 f#3 f#5 d5})
            assert_equal "DAdd9", @chord.name
            assert_equal 2, @chord.inversion
          end

        end

        context "6/9" do

          should "identify using note names" do
            @chord = MusicTheory::Chord.identify(%w{d f# a b e})
            assert_equal "D6/9", @chord.name
            assert_equal 0, @chord.inversion
          end

          should "identify using note names when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{f# a d b e})
            assert_equal "D6/9", @chord.name
            assert_equal 1, @chord.inversion
          end

          should "identify using note names when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{a f# d b e})
            assert_equal "D6/9", @chord.name
            assert_equal 2, @chord.inversion
          end

          should "identify across octaves" do
            @chord = MusicTheory::Chord.identify(%w{d1 f#2 a3 b3 e4})
            assert_equal "D6/9", @chord.name
            assert_equal 0, @chord.inversion
          end

          should "identify across octaves when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{f♯1 a2 b2 d3 e4})
            assert_equal "D6/9", @chord.name
            assert_equal 1, @chord.inversion
          end

          should "identify across octaves when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{a1 f#2 d3 b4 e4})
            assert_equal "D6/9", @chord.name
            assert_equal 2, @chord.inversion
          end

          should "identify when there are dup notes" do
            @chord = MusicTheory::Chord.identify(%w{a1 f#2 d3 b3 e4 a1 f#2 b5 f#5 d5})
            assert_equal "D6/9", @chord.name
            assert_equal 2, @chord.inversion
          end

        end

      end

      context "eleventh chords" do

        context "major" do

          should "identify using note names" do
            @chord = MusicTheory::Chord.identify(%w{C E G B D F♯})
            assert_equal "CMaj11", @chord.name
            assert_equal 0, @chord.inversion
          end

          should "identify using note names when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{E C G B D F♯})
            assert_equal "CMaj11", @chord.name
            assert_equal 1, @chord.inversion
          end

          should "identify using note names when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{G E C B D F♯})
            assert_equal "CMaj11", @chord.name
            assert_equal 2, @chord.inversion
          end

          should "identify using note names when in third inversion" do
            @chord = MusicTheory::Chord.identify(%w{B G E C D F♯})
            assert_equal "CMaj11", @chord.name
            assert_equal 3, @chord.inversion
          end

          should "identify across octaves" do
            @chord = MusicTheory::Chord.identify(%w{c0 e1 g1 b2 d2 f♯3})
            assert_equal "CMaj11", @chord.name
            assert_equal 0, @chord.inversion
          end

          should "identify across octaves when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{e0 c1 g1 b1 d2 f♯3})
            assert_equal "CMaj11", @chord.name
            assert_equal 1, @chord.inversion
          end

          should "identify across octaves when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{g1 e2 c3 b3 d4 f♯4})
            assert_equal "CMaj11", @chord.name
            assert_equal 2, @chord.inversion
          end

          should "identify across octaves when in third inversion" do
            @chord = MusicTheory::Chord.identify(%w{b0 g1 e2 c3 d4 f♯4})
            assert_equal "CMaj11", @chord.name
            assert_equal 3, @chord.inversion
          end

          should "identify using note names when there are dup notes" do
            @chord = MusicTheory::Chord.identify(%w{e1 c2 g2 b2 c2 d3 f♯3 d4})
            assert_equal "CMaj11", @chord.name
            assert_equal 1, @chord.inversion
          end

          should "identify across octaves with missing third" do
            @chord = MusicTheory::Chord.identify(%w{c0 g1 b2 d2 f♯3})
            assert_equal "CMaj11", @chord.name
            assert_equal 0, @chord.inversion
          end

          should "identify across octaves with missing fifth" do
            @chord = MusicTheory::Chord.identify(%w{c0 e1 b2 d2 f♯3})
            assert_equal "CMaj11", @chord.name
            assert_equal 0, @chord.inversion
          end

          should "identify across octaves with missing third and fifth" do
            @chord = MusicTheory::Chord.identify(%w{c0 b2 d2 f♯3})
            assert_equal "CMaj11", @chord.name
            assert_equal 0, @chord.inversion
          end

        end

        context "minor" do

          should "identify using note names" do
            @chord = MusicTheory::Chord.identify(%w{C E♭ G B♭ D F})
            assert_equal "CMin11", @chord.name
            assert_equal 0, @chord.inversion
          end

          should "identify using note names when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{E♭ B♭ G C D F})
            assert_equal "CMin11", @chord.name
            assert_equal 1, @chord.inversion
          end

          should "identify using note names when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{G E♭ B♭ C D F})
            assert_equal "CMin11", @chord.name
            assert_equal 2, @chord.inversion
          end

          should "identify using note names when in third inversion" do
            @chord = MusicTheory::Chord.identify(%w{B♭ G E♭ C D F})
            assert_equal "CMin11", @chord.name
            assert_equal 3, @chord.inversion
          end

          should "identify across octaves" do
            @chord = MusicTheory::Chord.identify(%w{c0 e♭1 g1 b♭2 d3 f4})
            assert_equal "CMin11", @chord.name
            assert_equal 0, @chord.inversion
          end

          should "identify across octaves when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{e♭0 b♭1 g1 c1 d2 f2})
            assert_equal "CMin11", @chord.name
            assert_equal 1, @chord.inversion
          end

          should "identify across octaves when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{g1 e♭1 b♭2 c2 d3 f3})
            assert_equal "CMin11", @chord.name
            assert_equal 2, @chord.inversion
          end

          should "identify across octaves when in third inversion" do
            @chord = MusicTheory::Chord.identify(%w{b♭0 g1 e♭1 c1 d3 f2})
            assert_equal "CMin11", @chord.name
            assert_equal 3, @chord.inversion
          end

          should "identify using note names when there are dup notes" do
            @chord = MusicTheory::Chord.identify(%w{g1 e♭1 b♭2 c2 d3 f3 d3 c3 c2})
            assert_equal "CMin11", @chord.name
            assert_equal 2, @chord.inversion
          end

          should "identify across octaves with missing fifth" do
            @chord = MusicTheory::Chord.identify(%w{c0 e♭1 b♭2 d3 f4})
            assert_equal "CMin11", @chord.name
            assert_equal 0, @chord.inversion
          end

          should "not identify with extraneous notes" do
            @chord = MusicTheory::Chord.identify(%w{c0 a♭1 e♭1 b♭2 d3 f4})
            refute_equal "CMin11", @chord.name
          end

        end

        context "dominant" do

          should "identify using note names" do
            @chord = MusicTheory::Chord.identify(%w{C E G B♭ D F})
            assert_equal "C11", @chord.name
            assert_equal 0, @chord.inversion
          end

          should "identify using note names when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{E G B♭ C D F})
            assert_equal "C11", @chord.name
            assert_equal 1, @chord.inversion
          end

          should "identify using note names when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{G B♭ C D E F})
            assert_equal "C11", @chord.name
            assert_equal 2, @chord.inversion
          end

          should "identify using note names when in third inversion" do
            @chord = MusicTheory::Chord.identify(%w{B♭ G C D E F})
            assert_equal "C11", @chord.name
            assert_equal 3, @chord.inversion
          end

          should "identify across octaves" do
            @chord = MusicTheory::Chord.identify(%w{c0 e0 g1 b♭1 d2 f3})
            assert_equal "C11", @chord.name
            assert_equal 0, @chord.inversion
          end

          should "identify across octaves when in first inversion" do
            @chord = MusicTheory::Chord.identify(%w{e1 g2 b♭2 c3 d4 f5})
            assert_equal "C11", @chord.name
            assert_equal 1, @chord.inversion
          end

          should "identify across octaves when in second inversion" do
            @chord = MusicTheory::Chord.identify(%w{g0 b♭1 c2 d3 e3 f4})
            assert_equal "C11", @chord.name
            assert_equal 2, @chord.inversion
          end

          should "identify across octaves when in third inversion" do
            @chord = MusicTheory::Chord.identify(%w{b♭0 g1 c1 d2 e2 f2})
            assert_equal "C11", @chord.name
            assert_equal 3, @chord.inversion
          end

          should "identify using note names when there are dup notes" do
            @chord = MusicTheory::Chord.identify(%w{b♭1 g1 c2 d3 e2 f3 e3 d3 g1})
            assert_equal "C11", @chord.name
            assert_equal 3, @chord.inversion
          end

          should "identify across octaves when missing third" do
            @chord = MusicTheory::Chord.identify(%w{c0 g1 b♭1 d2 f3})
            assert_equal "C11", @chord.name
            assert_equal 0, @chord.inversion
          end

          should "identify across octaves when missing fifth" do
            @chord = MusicTheory::Chord.identify(%w{c0 e1 b♭1 d2 f3})
            assert_equal "C11", @chord.name
            assert_equal 0, @chord.inversion
          end

          should "identify across octaves when missing third and fifth" do
            @chord = MusicTheory::Chord.identify(%w{c0 b♭1 d2 f3})
            assert_equal "C11", @chord.name
            assert_equal 0, @chord.inversion
          end

          should "not identify when 9th is a 2nd" do
            @chord = MusicTheory::Chord.identify(%w{c0 d0 b♭1 f3})
            refute_equal "C11", @chord.name
          end

          should "not identify when 11th is a 4nd" do
            @chord = MusicTheory::Chord.identify(%w{c0 f0 b♭1 d1})
            refute_equal "C11", @chord.name
          end

          should "not identify when containing extraneous notes" do
            @chord = MusicTheory::Chord.identify(%w{c0 b♭1 f#2 d2 f3})
            refute_equal "C11", @chord.name
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

        should "not identify clusters of notes as chords" do
          @chord = MusicTheory::Chord.identify(%w{a0 a#1 b1 c2 d3 d#1 e1 f#2 a5 g#2 b1 bb2})
          assert_nil @chord.name
          @chord = MusicTheory::Chord.identify(%w{a0 b1 c2 c#2 d3 d#3 e1 f2 f#2 g2 g#2 a5 g#2 b1 bb2})
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
        assert_equal "F♯Aug", MusicTheory::Chord.name(%w{f# a# c##})
      end

      should "name symbolic chord" do
        assert_equal "G♯♯Maj", MusicTheory::Chord.name(%w{g## b## d##})
      end

      should "name with midi notes" do
        assert_equal "EMin", MusicTheory::Chord.name(64, 67, 71)
      end

    end

  end

end
