require "helper"

class MusicTheory::Chord::RawTest < Minitest::Test

  context "MusicTheory::Chord::RawTest" do

    context "#initialize" do

      context "chars" do

        setup do
          @chord = MusicTheory::Chord::Raw.new("a", "B")
        end

        should "be populated" do
          assert_equal 2, @chord.members.size
          assert_equal "A", @chord.members.first.name
          assert_equal "B", @chord.members.last.name
        end
      end

      context "mixed" do

        setup do
          @chord = MusicTheory::Chord::Raw.new("a", :b)
        end

        should "be populated" do
          assert_equal 2, @chord.members.size
          assert_equal "A", @chord.members.first.name
          assert_equal "B", @chord.members.last.name
        end

      end

      context "numbers" do

        setup do
          @chord = MusicTheory::Chord::Raw.new(0,4,7)
        end

        should "be populated" do
          assert_equal "C", @chord.members[0].name
          assert_equal "E", @chord.members[1].name
          assert_equal "G", @chord.members[2].name
        end

      end

      context "array" do

        setup do
          @chord = MusicTheory::Chord::Raw.new(%w{a c d# f})
        end

        should "be populated" do
          assert_equal 4, @chord.members.size
          assert_equal "A", @chord.members.first.name
          assert_equal "F", @chord.members.last.name
        end

      end

    end

    context "analyze" do

      context "major seventh" do

        setup do
          @id = MusicTheory::Chord::Raw.analyze(%w{d f# a c#})
        end

        should "be assigned" do
          refute_nil @id
        end

        should "be populated with chords" do
          refute_nil @id.included_chords
          refute_empty @id.included_chords
        end

      end

    end

  end

end
