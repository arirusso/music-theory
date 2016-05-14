module MusicTheory

  # an immutable note
  class Note

    MATCHER = {
      :accidental => /^[a,b,c,d,e,f,g]([#,b,s])/,
      :name => /^[a,b,c,d,e,f,g]/,
      :octave => /\d+$/
    }.freeze

    attr_reader :accidental,
                :id,
                :name,
                :octave

    def initialize(id, options = {})
      case id
        when Integer then process_integer(id)
        when String then process_string(id)
        when Symbol then process_string(id.to_s)
      end
      process_options(options)
      construct_id
    end

    def midi_note_num(options = {})
      base = options[:octave] || 0
      interval = %{c d e f g a b}.index(@name.downcase)
      octave_start = @octave.nil? ? base : (12 * @octave) + 12
      octave_start + interval + mod
    end

    def mod
      mod = 0
      unless @accidental.nil?
        @accidental.each_char do |char|
          mod += case char
            when "#" then 1
            when "b" then -1
          end
        end
      end
      mod
    end

    private

    def construct_id
      @id = ""
      @id += @name.to_s
      @id += @accidental.to_s
      @id += @octave.to_s
      @id
    end

    def process_integer(int)
      octave, note = *int.divmod(12)
      name = %w{c c# d d# e f f# g g# a bb b}.at(note)
      process_string("#{name}#{(octave - 1)}")
    end

    def process_options(options = {})
      @accidental ||= options[:accidental]
      @octave ||= options[:octave]
    end

    def process_string(id)
      id = id.downcase
      if id.match(MATCHER[:octave])
        @octave = id.match(MATCHER[:octave])[0].to_i
      end
      if id.match(MATCHER[:name])
        @name = id.match(MATCHER[:name])[0].upcase.to_s
      end
      if id.match(MATCHER[:accidental])
        @accidental = id.match(MATCHER[:accidental])[1].downcase.to_s
        @accidental.gsub!(/s/, "#")
      end
    end

  end

end
