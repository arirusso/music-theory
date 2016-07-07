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
          assert_equal MusicTheory::Note::Value::Calculate.octave_start(@octave), @chord.root.value.number
        end

      end

    end

  end

end
