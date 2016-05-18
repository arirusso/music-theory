require "helper"

class MusicTheory::Scale::AnalysisTest < Minitest::Test

  context "MusicTheory::Scale::Analysis" do

    context "#mode" do

      context "from major scale" do

        setup do
          @set = MusicTheory::Set.new(0, 2, 4, 5, 7, 9, 11)
          @analysis = MusicTheory::Scale::Analysis.new(@set)
        end

        should "identify mode" do
          #assert_equal :ionian, @analysis.mode
        end

      end

      context "from minor scale" do

      end

    end

    context "#diatonic" do

      context "major" do

        setup do
          @set = MusicTheory::Set.new(0, 2, 4, 5, 7, 9, 11)
          @analysis = MusicTheory::Scale::Analysis.new(@set)
        end

        should "identify scale" do
          assert_equal :major, @analysis.diatonic
        end
        
      end

      context "minor" do
      end

    end

  end

end
