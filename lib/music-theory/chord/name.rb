module MusicTheory

  module Chord

    class Name < String

      attr_reader :abbrev, :root

      def initialize(obj)
        populate(obj)
        super(to_s)
        freeze
      end

      def to_s
        "#{@root.letter}#{@root.accidental}#{@abbrev}"
      end

      private

      def populate(obj)
        case obj
        when String then populate_from_string(obj)
        when Voicing then populate_from_voicing(obj)
        end
      end

      def populate_from_string(string)
        @root = Parser.root_note_name(string)
        @abbrev = Parser.abbreviation(string)
      end

      def populate_from_voicing(voicing)
        @abbrev = voicing.dictionary[:abbrev].to_s
        @root = voicing.root
      end

      module Parser

        MATCH = {
          :abbrev => /(#{Dictionary.abbreviations.map(&:to_s).join('|')})$/i
        }

        extend self

        def abbreviation(string)
          if string.match(MATCH[:abbrev])
            type = string.match(MATCH[:abbrev])[0]
            type[0] = type[0].upcase
            type
          end
        end

        def root_note_name(string)
          unless (letter = MusicTheory::Note::Name::Parser.letter(string)).nil?
            accidental = MusicTheory::Note::Name::Parser.accidental(string)
            MusicTheory::Note::Name.find("#{letter}#{accidental}")
          end
        end

      end

    end

  end

end
