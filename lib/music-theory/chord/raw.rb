module MusicTheory

  module Chord

    class Raw

      attr_reader :members
      alias_method :notes, :members

      def self.analyze(*args)
        new(*args).analyze
      end

      def initialize(*args)
        @members = []
        process_args(*args)
      end

      def triad_names
        analyze.triad_names
      end

      def analyze
        @analysis ||= Analysis.new(*@members)
      end

      private

      def process_args(*args)
        args.each do |item|
          case item
          when Array then process_args(*item)
          when Note::Instance then @members << item
          else @members << Note.new(item)
          end
        end
      end

    end

  end

end
