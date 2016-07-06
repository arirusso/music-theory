module MusicTheory

  module Chord

    class Name < String

      MATCH = {
        :abbrev => /(#{Dictionary.abbreviations.map(&:to_s).join('|')})$/i
      }

      attr_reader :abbrev, :root

      def initialize(obj)
        case obj
        when String then populate_from_string(obj)
        when Voicing then populate_from_voicing(obj)
        end
        super(string_from_properties)
        freeze
      end

      def self.parse_abbrev(string)
        if string.match(MATCH[:abbrev])
          type = string.match(MATCH[:abbrev])[0]
          type[0] = type[0].upcase
          type
        end
      end

      private

      def string_from_properties
        "#{@root.letter}#{@root.accidental}#{@abbrev}"
      end

      def populate_from_string(string)
        string = string.downcase
        letter = MusicTheory::Note::Name::Parser.letter(string)
        accidental = MusicTheory::Note::Name::Parser.accidental(string)
        @root = MusicTheory::Note::Name.find("#{letter}#{accidental}")
        @abbrev = self.class.parse_abbrev(string)
      end

      def populate_from_voicing(voicing)
        @abbrev = voicing.dictionary[:abbrev].to_s
        @root = voicing.root
      end

    end

  end

end
