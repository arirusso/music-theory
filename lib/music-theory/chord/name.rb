module MusicTheory

  module Chord

    class Name < String

      extend Forwardable

      def_delegators :@root, :accidental, :letter
      attr_reader :abbreviation, :root

      def initialize(obj, options = {})
        populate(obj, options)
        super(to_s)
        freeze
      end

      def to_s
        "#{@root.letter}#{@root.accidental}#{@abbreviation}"
      end

      private

      def populate(obj, options = {})
        case obj
        when String then populate_from_string(obj, options)
        when Voicing then populate_from_voicing(obj)
        end
      end

      def populate_from_string(string, options = {})
        @root = Parser.root_note_name(string, options)
        @abbreviation = Parser.abbreviation(string)
      end

      def populate_from_voicing(voicing)
        @abbreviation = voicing.dictionary[:abbrev].to_s
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

        def root_note_name(string, options = {})
          unless (letter = MusicTheory::Note::Name::Parser.letter(string)).nil?
            accidental = MusicTheory::Note::Name::Parser.accidental(string)
            MusicTheory::Note::Name.find("#{letter}#{accidental}", options)
          end
        end

      end

    end

  end

end
