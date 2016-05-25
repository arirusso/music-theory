module MusicTheory

  module Chord

    class Analysis

      attr_reader :chords, :notes

      def initialize(*args)
        @notes = args
        populate_chords
      end

      def includes_triad?(name)
        !triads.select(&:name).empty?
      end

      def includes_seventh_chord?(name)
        !seventh_chords.select(&:name).empty?
      end

      def chord
        @chords
          .select { |chord| chord.size == largest_size }
          .reject { |chord| chord.inversion.nil? }
          .sort_by(&:inversion)
          .first
      end

      def seventh_chords
        @chords.select(&:seventh?)
      end

      def triads
        @chords.select(&:triad?)
      end

      def triad_names
        triads.map(&:name)
      end

      def largest_size
        largest.size
      end

      def largest
        @chords.sort_by(&:size).last
      end

      private

      def populate_chords
        @chords = DICTIONARY.keys.map do |key|
          Voicing.find_all(key, @notes)
        end.compact.flatten
      end

      CHORD_DELEGATION_METHODS = [:inversion, :name, :root, :seventh?, :triad?].freeze

      def method_missing(method, *args, &block)
        if CHORD_DELEGATION_METHODS.include?(method)
          chord.send(method, *args, &block) if !chord.nil?
        else
          super
        end
      end

      def respond_to_missing?(method, include_private = false)
        CHORD_DELEGATION_METHODS.include?(method) || super
      end

    end

  end

end
