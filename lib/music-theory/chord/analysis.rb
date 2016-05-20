module MusicTheory

  module Chord

    class Analysis

      TRIAD = {
        :major => {
          :abbrev => :maj,
          :intervals => [0, 4, 7]
        },
        :minor => {
          :abbrev => :min,
          :intervals => [0, 3, 7]
        },
        :diminished => {
          :abbrev => :dim,
          :intervals => [0, 3, 5]
        },
        :augmented => {
          :abbrev => :aug,
          :intervals => [0, 4, 8]
        }
      }.freeze

      EXTENDED = {
        :minor_seventh => {
          :abbrev => :min7,
          :intervals => [0, 10]
        },
        :major_seventh => {
          :abbrev => :maj7,
          :intervals => [0, 11]
        }
      }

      INVERSION = [
        [0],
        [3, 4],
        [5, 7],
        [10, 11]
      ].freeze

      attr_reader :members, :root, :triads

      def initialize(*args)
        @members = args
        populate_triads
        populate_root
      end

      # Get the name of the chord
      # @return [Symbol]
      def name
        triad = TRIAD[triad_names.first]
        type = triad[:abbrev].to_s
        type[0] = type[0].upcase
        (root.name + type).to_sym
      end

      def has_triad?(name)
        !@triads.select { |triad| triad[:name] }.empty?
      end

      def triad_names
        @triad_names ||= @triads.map { |triad| triad[:name] }
      end

      def inversion
        key = INVERSION.find { |k| k.include?(abs_notes(@members).first) }
        INVERSION.index(key)
      end

      private

      def get_inversion(triad, notes)
        triad = triad.dup
        i = 0
        while notes[0] != triad[0] && i < notes.count
          triad.rotate!
          i += 1
        end
        i
      end

      def abs_notes(collection)
        numbers = collection.map { |note| note.midi_note_num || note.interval_above_c }
        collapsed_members = Scale::Degree.collapse_all(numbers)
        Scale::Degree.normalize(collapsed_members)
      end

      def populate_triads
        @triads = []
        TRIAD.keys.each do |name|
          triad = TRIAD[name.to_sym]
          abs = abs_notes(@members)
          union = triad[:intervals] & abs
          if union == triad[:intervals]
            notes = union.map do |member|
              index = abs.index(member)
              @members[index]
            end
            inversion = get_inversion(triad[:intervals], abs)
            @triads << {
              :inversion => inversion,
              :members => notes,
              :name => name.to_sym
            }
          end
        end
        @triads
      end

      def populate_root
        members = abs_notes(@members).sort
        root = nil
        i = 0
        while root.nil? && i < members.size
          identifiers = TRIAD.values.map { |triad| triad[:intervals] }
          if identifiers.any? { |identifier| identifier == members[0..identifier.size-1] }
            root = members[0]
          else
            members.rotate!
            i += 1
          end
        end
        unless root.nil?
          index = abs_notes(@members).index(root)
          @root = @members[index]
        end
      end

    end

  end

end
