require "helper"

class MusicTheory::Scale::AnalysisTest < Minitest::Test

  context "MusicTheory::Scale::Analysis" do

    context "#mode" do

      context "from major scale" do

        context "ionian" do

          setup do
            @set = MusicTheory::Interval::Set.new(0, 2, 4, 5, 7, 9, 11)
            @analysis = MusicTheory::Scale::Analysis.new(@set)
          end

          should "identify mode" do
            assert_equal :ionian, @analysis.mode
          end

        end

      end

      context "from minor scale" do

      end

    end

    context "#scale" do

      context "major" do

        setup do
          @set = MusicTheory::Interval::Set.new(0, 2, 4, 5, 7, 9, 11)
          @analysis = MusicTheory::Scale::Analysis.new(@set)
        end

        should "identify scale" do
          assert_equal :major, @analysis.scale
        end

      end

      context "minor" do

        context "natural" do

          setup do
            @set = MusicTheory::Interval::Set.new(0, 2, 3, 5, 7, 8, 10)
            @analysis = MusicTheory::Scale::Analysis.new(@set)
          end

          should "identify scale" do
            assert_equal({ :minor => :natural }, @analysis.scale)
          end

        end

      end

    end

  end

end
