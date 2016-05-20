module MusicTheory

  module Chord

    class Analysis

      attr_reader :members, :root, :triads

      def initialize(*args)
        @members = args
        populate_triads
        populate_root
      end

      # Get the name of the chord
      # @return [Symbol]
      def name
        triad = DICTIONARY[:triad][triad_names.first]
        type = triad[:abbrev].to_s
        type[0] = type[0].upcase
        (root.name + type).to_sym
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

      def populate_root
        members = Interval.map(@members).sort
        root = nil
        i = 0
        while root.nil? && i < members.size
          identifiers = DICTIONARY[:triad].values.map { |triad| triad[:intervals] }
          if identifiers.any? { |identifier| identifier == members[0..identifier.size-1] }
            root = members[0]
          else
            members.rotate!
            i += 1
          end
        end
        unless root.nil?
          index = Interval.map(@members).index(root)
          @root = @members[index]
        end
      end

    end

  end

end
