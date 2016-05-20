module MusicTheory

  module Chord

    class Seventh

      attr_reader :inversion, :name, :members, :root

      def self.find_all(notes)
      end

      def initialize(name, notes)
        @name = name.to_sym
        populate_notes(notes)
      end

      def dictionary
        DICTIONARY[:seventh][@name]
      end

      private

      def populate_notes(notes)
      end
      
    end

  end

end
