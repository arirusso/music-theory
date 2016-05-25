module MusicTheory

  module Chord

    class Analysis

      attr_reader :members, :included_chords

      def initialize(*args)
        @members = args
        populate_included_chords
      end

      def triad?
        is_chord.triad?
      end

      def seventh?
        is_chord.seventh?
      end

      # Get the name of the chord
      # @return [Symbol]
      def name
        unless (chord = is_chord).nil?
          dict = chord.dictionary
          type = dict[:abbrev].to_s
          type[0] = type[0].upcase
          (root.name + type).to_sym
        end
      end

      def includes_triad?(name)
        !triads.select(&:name).empty?
      end

      def includes_seventh_chord?(name)
        !seventh_chords.select(&:name).empty?
      end

      def is_chord
        @included_chords
          .select { |chord| chord.size == largest_size }
          .reject { |chord| chord.inversion.nil? }
          .sort_by(&:inversion)
          .first
      end

      def root
        is_chord.root
      end

      def seventh_chords
        @included_chords.select(&:seventh?)
      end

      def triads
        @included_chords.select(&:triad?)
      end

      def triad_names
        triads.map(&:name)
      end

      def inversion
        is_chord.inversion
      end

      def largest_size
        largest.size
      end

      def largest
        @included_chords.sort_by(&:size).last
      end

      private

      def populate_included_chords
        @included_chords = DICTIONARY.keys.map do |key|
          Voicing.find_all(key, @members)
        end.compact.flatten
      end

    end

  end

end
