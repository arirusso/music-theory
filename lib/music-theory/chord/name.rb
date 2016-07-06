module MusicTheory

  module Chord

    class Name < String

      MATCH = {
        :abbrev => /(#{Dictionary.abbreviations.map(&:to_s).join('|')})$/i
      }

      attr_reader :abbrev, :root_symbol

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
        "#{@root_symbol.name}#{@root_symbol.accidental}#{@abbrev}"
      end

      def populate_from_string(string)
        string = string.downcase
        name = MusicTheory::Note::Symbol.parse_name(string)
        accidental = MusicTheory::Note::Symbol.parse_accidental(string)
        @root_symbol = MusicTheory::Note::Symbol.new("#{name}#{accidental}")
        @abbrev = self.class.parse_abbrev(string)
      end

      def populate_from_voicing(voicing)
        @abbrev = voicing.dictionary[:abbrev].to_s
        @root_symbol = voicing.root.symbol
      end

    end

  end

end
