require "helper"

class MusicTheory::Chord::BuilderTest < Minitest::Test

  context "MusicTheory::Chord::Builder" do

    context "#build" do

      context "major chord, root inversion" do

        setup do
          @octave = 3
          @chord = MusicTheory::Chord::Builder.build("CMaj", octave: @octave)
        end

        should "reflect correct root" do
          refute_nil @chord.root
          refute_nil @chord.root.value
          refute_nil @chord.root.value.number
          assert_equal MusicTheory::Note::Value::Calculate.octave_start(@octave), @chord.root.value.number
          assert_equal "C", @chord.root.letter
          assert_equal @octave, @chord.root.octave
        end

      end

    end

  end

end
