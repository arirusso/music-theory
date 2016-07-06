module MusicTheory

  module Chord

    class Analysis

      attr_reader :notes

      def initialize(*args)
        @notes = args
      end

      def chord
        @chord ||= chords_by_precedence.first
      end

      def chords
        @chords ||= Voicing.find_all(@notes)
      end

      private

      def largest_chord_size
        largest_chord.size
      end

      def largest_chord
        @largest_chord ||= chords.sort_by(&:size).last
      end

      def chords_by_precedence
        chords
          .select { |chord| chord.size == largest_chord_size }
          .reject { |chord| chord.inversion.nil? }
          .reject { |chord| @notes.any? { |note| !chord.include_relative?(note) } }
          .sort_by(&:inversion)
      end

      CHORD_DELEGATION_METHODS = [:intervals, :inversion, :name, :root, :seventh?, :triad?].freeze

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
