module MusicTheory

  module Chord

    class Analysis

      attr_reader :members, :root, :triads

      def initialize(*args)
        @members = args
        populate_triads
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
        @triads.first.root
      end
      
      def has_triad?(name)
        !@triads.select { |triad| triad.name }.empty?
      end

      def triad_names
        @triad_names ||= @triads.map { |triad| triad.name }
      end

      def inversion
        @inversion ||= @triads.first.inversion
      end

      private

      def populate_triads
        @triads = Triad.find_all(@members)
      end

    end

  end

end
