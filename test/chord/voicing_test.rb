require "helper"

class MusicTheory::Chord::VoicingTest < Minitest::Test

  context "MusicTheory::Chord::Voicing" do

    context ".get_inversion" do

      should "recognize root inversion" do
        assert_equal 0, MusicTheory::Chord::Voicing.send(:get_inversion, [0, 4, 7], [0, 4, 7])
        assert_equal 0, MusicTheory::Chord::Voicing.send(:get_inversion, [0, 4, 7], [0, 7, 4])
        assert_equal 0, MusicTheory::Chord::Voicing.send(:get_inversion, [0, 4, 7], [0, 7, 4, 11])
        assert_equal 0, MusicTheory::Chord::Voicing.send(:get_inversion, [0, 4, 7], [0, 11, 7, 4])
      end

      should "recognize first inversion" do
        assert_equal 1, MusicTheory::Chord::Voicing.send(:get_inversion, [0, 4, 7], [4, 0, 7])
        assert_equal 1, MusicTheory::Chord::Voicing.send(:get_inversion, [0, 4, 7], [4, 7, 0])
        assert_equal 1, MusicTheory::Chord::Voicing.send(:get_inversion, [0, 4, 7], [4, 7, 0, 11])
        assert_equal 1, MusicTheory::Chord::Voicing.send(:get_inversion, [0, 4, 7], [4, 11, 7, 0])
      end

      should "recognize second inversion" do
        assert_equal 2, MusicTheory::Chord::Voicing.send(:get_inversion, [0, 4, 7], [7, 0, 4])
        assert_equal 2, MusicTheory::Chord::Voicing.send(:get_inversion, [0, 4, 7], [7, 4, 0])
        assert_equal 2, MusicTheory::Chord::Voicing.send(:get_inversion, [0, 4, 7], [7, 0, 4, 11])
        assert_equal 2, MusicTheory::Chord::Voicing.send(:get_inversion, [0, 4, 7], [7, 11, 4, 0])
      end

      should "recognize third inversion" do
        assert_equal 3, MusicTheory::Chord::Voicing.send(:get_inversion, [0, 4, 7, 11], [11, 7, 0, 4])
        assert_equal 3, MusicTheory::Chord::Voicing.send(:get_inversion, [0, 4, 7, 11], [11, 0, 7, 4])
        assert_equal 3, MusicTheory::Chord::Voicing.send(:get_inversion, [0, 4, 7, 11], [11, 4, 7, 0])
        assert_equal 3, MusicTheory::Chord::Voicing.send(:get_inversion, [0, 4, 7, 11], [11, 4, 0, 7])
      end

    end
  end
end
