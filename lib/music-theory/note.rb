module MusicTheory

  # an immutable note
  class Note

    NAME = {
      :c => "c",
      :d => "d",
      :e => "e",
      :f => "f",
      :g => "g",
      :a => "a",
      :b => "b"
    }.freeze

    SHARP = "#".freeze
    FLAT = "b".freeze

    MATCH = {
      :accidental => /^[#{NAME.values.join(',')}]([#{SHARP},#{FLAT},s]+)/,
      :name => /^[#{NAME.values.join(',')}]/,
      :octave => /\d+$/
    }.freeze

    DEFAULT_SCALE = %w{c c# d d# e f f# g g# a bb b}.freeze

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
      octave = options[:octave] || @octave
      unless octave.nil?
        octave_start = (12 * octave) + 12
        octave_start + interval_above_c + mod
      end
    end

    # The intervalic value of this note's accidental
    # @return [Fixnum]
    def mod
      mod = 0
      unless @accidental.nil?
        @accidental.each_char do |char|
          mod += case char
          when SHARP then 1
          when FLAT then -1
          end
        end
      end
      mod
    end

    private

    # The interval of this note above C (in C Major)
    # @return [Fixnum]
    def interval_above_c
      scale_degree = NAME.keys.index(@name.downcase.to_sym)
      Scale::Analysis::SCALE[:major][scale_degree]
    end

    def construct_id
      @id = ""
      @id += @name.to_s
      @id += @accidental.to_s
      @id += @octave.to_s
      @id
    end

    def process_integer(int)
      octave, note = *int.divmod(12)
      name = DEFAULT_SCALE.at(note)
      process_string("#{name}#{(octave - 1)}")
    end

    def process_options(options = {})
      @accidental ||= options[:accidental]
      @octave ||= options[:octave]
    end

    def process_string(id)
      id = id.downcase
      if id.match(MATCH[:octave])
        @octave = id.match(MATCH[:octave])[0].to_i
      end
      if id.match(MATCH[:name])
        @name = id.match(MATCH[:name])[0].upcase.to_s
      end
      if id.match(MATCH[:accidental])
        @accidental = id.match(MATCH[:accidental])[1].downcase.to_s
        @accidental.gsub!(/s/, SHARP)
      end
    end

  end

end
