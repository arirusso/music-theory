module MusicTheory

  module Chord

    class Name < String

      MATCH = {
        :abbrev => /(#{Dictionary.abbreviations.map(&:to_s).join('|')})$/i
      }

      attr_reader :abbrev, :root_id

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
        "#{@root_id.name}#{@root_id.accidental}#{@abbrev}"
      end

      def populate_from_string(string)
        string = string.downcase
        name = MusicTheory::Note::Signature.parse_name(string)
        accidental = MusicTheory::Note::Signature.parse_accidental(string)
        @root_id = MusicTheory::Note::Signature.new("#{name}#{accidental}")
        @abbrev = self.class.parse_abbrev(string)
      end

      def populate_from_voicing(voicing)
        @abbrev = voicing.dictionary[:abbrev].to_s
        @root_id = voicing.root.id
      end

    end

  end

end
