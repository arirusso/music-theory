require "helper"

class MusicTheory::Chord::NameTest < Minitest::Test

  context "MusicTheory::Chord::NameTest" do

    context "#initialize" do

      should "init from string" do
        @name = MusicTheory::Chord::Name.new("DMaj7")
        refute_nil @name
        refute_nil @name.abbrev
        refute_nil @name.root_id
        assert_equal "Maj7", @name.abbrev
        assert_equal @name.root_id, "D"
      end

    end

    context "#==" do

      should "match like names" do
        @name1 = MusicTheory::Chord::Name.new("DMaj7")
        @name2 = MusicTheory::Chord::Name.new("DMaj7")
        assert_equal @name1, @name2
      end

      should "not match unlike names" do
        @name1 = MusicTheory::Chord::Name.new("CMaj9")
        @name2 = MusicTheory::Chord::Name.new("EMaj7")
        refute_equal @name1, @name2
      end

      should "match sharp symbols" do
        @name1 = MusicTheory::Chord::Name.new("F#Maj7")
        @name2 = MusicTheory::Chord::Name.new("F♯Maj7")
        assert_equal @name1, @name2
      end

      should "match flat symbols" do
        @name1 = MusicTheory::Chord::Name.new("EbMaj7")
        @name2 = MusicTheory::Chord::Name.new("E♭Maj7")
        assert_equal @name1, @name2
      end

    end

  end

end
