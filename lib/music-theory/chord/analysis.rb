module MusicTheory

  module Chord

    class Analysis

      ATTRIBUTES = {
        :major => {
          :abbrev => :maj,
          :intervals => [0,4]
        },
        :minor => {
          :abbrev => :min,
          :intervals => [0,3]
        },
        :diminished => {
          :abbrev => :dim,
          :intervals => [0,3,5]
        },
        :augmented => {
          :abbrev => :aug,
          :intervals => [0,4,8]
        },
        :minor_seventh => {
          :abbrev => :min7,
          :intervals => [0,10]
        },
        :major_seventh => {
          :abbrev => :maj7,
          :intervals => [0,11]
        }
      }.freeze

      INVERSION = {
        [0] => 0,
        [3, 4] => 1,
        [5, 7] => 2,
        [10, 11] => 3
      }.freeze

      attr_reader :members

      def initialize(*args)
        @members = args
      end

      # Get the root member of the chord
      # @return [Note]
      def root
        if @root.nil?
          members = abs_members.sort
          root = nil
          i = 0
          while root.nil? && i < members.size
            identifiers = ATTRIBUTES.values.map { |attr| attr[:intervals] }
            if identifiers.any? { |identifier| identifier == members[0..identifier.size-1] }
              root = members[0]
            else
              members.rotate!
              i += 1
            end
          end
          unless root.nil?
            index = abs_members.index(root)
            @root = @members[index]
          end
        end
        @root
      end

      # Get the name of the chord
      # @return [Symbol]
      def name
        attr = ATTRIBUTES[attributes.first]
        type = attr[:abbrev].to_s
        type[0] = type[0].upcase
        (root.name + type).to_sym
      end

      def has_attribute?(name)
        attribute = ATTRIBUTES[name.to_sym]
        (attribute[:intervals] & abs_members) == attribute[:intervals]
      end

      def attributes
        ATTRIBUTES.keys.select { |name| has_attribute?(name) }
      end

      def inversion
        key = INVERSION.keys.find { |k| k.include?(abs_members.first) }
        INVERSION[key]
      end

      def abs_members
        numbers = @members.map { |note| note.midi_note_num || note.interval_above_c }
        collapsed_members = Scale::Degree.collapse_all(numbers)
        Scale::Degree.normalize(collapsed_members)
      end

    end

  end

end
