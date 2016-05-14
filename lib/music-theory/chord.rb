module MusicTheory

  class Chord

    attr_reader :members
    alias_method :notes, :members

    def initialize(*args)
      @members = []
      process_args(*args)
    end

    def self.[](*args)
      new(*args)
    end

    def attributes
      ChordAnalysis.find(*@members.map(&:midi_note_num)).attributes
    end

    private

    def process_args(*args)
      args.each do |item|
        case item
          when Array then process_args(*item)
          when Note then @members << item
          else @members << Note.new(item)
        end
      end
    end

  end

end
