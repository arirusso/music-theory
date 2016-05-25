module MusicTheory

  module Chord

    class Analysis

      attr_reader :members, :root, :triads

      def initialize(*args)
        @members = args
        @included_chords = {}
        populate_triads
        populate_sevenths
      end

      def triad?
        !@included_chords[:triad].empty? &&
          @included_chords[:triad].count == 1 &&
          @included_chords[:seventh].empty? &&
          @included_chords[:extended].empty?
      end

      def seventh?
        !@included_chords[:seventh].empty? &&
          @included_chords[:seventh].count == 1 &&
          @included_chords[:extended].empty?
      end

      # Get the name of the chord
      # @return [Symbol]
      def name
        triad = DICTIONARY[:triad][triad_names.first]
        type = triad[:abbrev].to_s
        type[0] = type[0].upcase
        (root.name + type).to_sym
      end

      def root
        @included_chords[:triad].first.root
      end

      def has_triad?(name)
        !@included_chords[:triad].select(&:name).empty?
      end

      def triad_names
        @triad_names ||= @included_chords[:triad].map(&:name)
      end

      def inversion
        @inversion ||= @included_chords[:triad].first.inversion
      end

      private

      def populate_sevenths
      end

      def populate_triads
        @included_chords[:triad] = Voicing.find_all(:triad, @members)
      end

    end

  end

end
