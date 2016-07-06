module MusicTheory

  module Chord

    class Voicing

      attr_reader :intervals, :inversion, :members, :name, :type

      class << self

        def find_all(notes)
          DICTIONARY.keys.map { |type| find_all_by_type(type, notes) }.compact.flatten
        end

        private

        def find_all_by_type(type, notes)
          @cache ||= {}
          @cache[type] ||= {}
          @cache[type][notes] ||= permutations(type, notes).map do |permutation|
            new(type, permutation[:name], notes, :root_index => permutation[:root_index])
          end
        end

        def permutations(type, notes)
          permutations = DICTIONARY[type].map do |name, dictionary|
            unless (permutation_sets = Match.interval_permutations(dictionary, notes)).empty?
              permutation_sets.uniq.map do |set|
                {
                  root_index: set.index(0),
                  name: name
                }
              end
            end
          end
          permutations.flatten.compact.uniq
        end

      end

      def initialize(type, dictionary_key, notes, options = {})
        @dictionary_key = dictionary_key
        @type = type.to_sym
        populate(notes, :root_index => options[:root_index])
      end

      def root
        @root ||= @intervals[0].first
      end

      def include?(note)
        @members.include?(note)
      end

      def include_relative?(note)
        @members.any? { |member| member.value.to_interval_above_c == note.value.to_interval_above_c }
      end

      def ==(o)
        (o.class == self.class) &&
          o.members == @members &&
          o.root == root &&
          o.inversion == @inversion &&
          o.name == @name &&
          o.type == @type
      end
      alias_method :eql?, :==

      def size
        @members.size
      end

      def triad?
        @type == :triad
      end

      def seventh?
        @type == :seventh
      end

      def lowest_note
        @members.sort_by(&:midi_note_num).first
      end

      def dictionary
        DICTIONARY[@type][@dictionary_key]
      end

      private

      def dictionary_intervals
        if @dictionary_intervals.nil?
          dict = dictionary[:intervals]
          unless dictionary[:optional_intervals].nil?
            dict += dictionary[:optional_intervals]
            dict.sort!
          end
          @dictionary_intervals = dict
        end
        @dictionary_intervals
      end

      def reduced_dictionary_intervals
        @reduced_dictionary_intervals ||= Interval.reduce(dictionary_intervals)
      end

      def populate(notes, options = {})
        root_index = options[:root_index]
        root = notes[root_index]
        @intervals = {}
        @members = notes.select do |note|
          interval = (note.value.to_interval_above_c + 12) - root.value.to_interval_above_c
          reduced_int = interval % 12
          reduced_dict_index = reduced_dictionary_intervals.index(reduced_int)
          unless reduced_dict_index.nil?
            dict_int = dictionary_intervals.at(reduced_dict_index)
            @intervals[dict_int] ||= []
            @intervals[dict_int] << note
            true
          end
        end
        @intervals.each do |interval, notes|
          notes.sort_by! { |note| note.value.number }
        end
        populate_inversion
        populate_name
        freeze
        @members
      end

      def freeze
        @members.freeze
        @intervals.freeze
        super
      end

      def populate_inversion
        first_interval = @intervals.select { |k, v| v.include?(@members.first) }.keys.first
        @inversion = reduced_dictionary_intervals.index(first_interval).freeze
      end

      def populate_name
        @name = Chord::Name.new(self)
      end

    end

  end

end
