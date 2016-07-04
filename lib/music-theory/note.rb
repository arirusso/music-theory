module MusicTheory

  # An immutable note
  class Note

    include Comparable

    NAME = {
      :c => "c",
      :d => "d",
      :e => "e",
      :f => "f",
      :g => "g",
      :a => "a",
      :b => "b"
    }.freeze

    SHARP = %w{♯ # s}.freeze
    FLAT = %w{♭ b}.freeze

    MATCH = {
      :accidental => /^[#{NAME.values.join(',')}]([#{SHARP.join(',')},#{FLAT.join(',')},s]+)/,
      :name => /^[#{NAME.values.join(',')}]/,
      :octave => /\d+$/
    }.freeze

    DEFAULT_SCALE = %w{c c# d d# e f f# g g# a bb b}.freeze

    attr_reader :accidental,
                :id,
                :name,
                :octave

    def initialize(id, options = {})
      id = parse_id(id)
      process_options(options)
      construct_id
    end

    def <=>(o)
      num <=> o.num
    end

    def num(options = {})
      octave = options[:octave] || @octave
      unless octave.nil?
        octave_start = (12 * octave) + 12
        octave_start + interval_above_c
      end
    end
    alias_method :midi_note_num, :num

    # The intervalic value of this note's accidental
    # @return [Fixnum]
    def mod
      mod = 0
      unless @accidental.nil?
        @accidental.each_char do |char|
          mod += case char
          when /[#{SHARP.join(',')}]/ then 1
          when /[#{FLAT.join(',')}]/ then -1
          end
        end
      end
      mod
    end

    def interval_above_c
      as_c_major_scale_degree + mod
    end

    def octave?
      !@octave.nil?
    end

    private

    def parse_id(id)
      case id
        when Array then id.map { |member| parse_id(member) }
        when Fixnum then process_number(id)
        when String then process_string(id)
        when Symbol then process_string(id.to_s)
      end
    end

    # The interval of this note above C (in C Major)
    # @return [Fixnum]
    def as_c_major_scale_degree
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

    def process_number(int)
      octave, note = *int.divmod(12)
      name = DEFAULT_SCALE.at(note)
      string = "#{name}#{(octave - 1)}"
      process_string(string)
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
        @accidental.gsub!(/[#{SHARP.join(',')}]/, SHARP.first)
        @accidental.gsub!(/[#{FLAT.join(',')}]/, FLAT.first)
      end
    end

  end

end
