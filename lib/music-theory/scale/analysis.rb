module MusicTheory

  class Scale

    class Analysis

      def initialize(set)
        @set = set
      end

      def scale(options = {})
        matches(options).last
      end

      def matches(options = {})
        set = options.fetch(:set, @set)
        reduced = reduce(set: set).to_a
        matches = []
        DICTIONARY.each do |key, value|
          match_dictionary_level(matches, reduced, value, key)
        end
        matches
      end

      def mode
        reduced = reduce
        i = 0
        scales = nil
        until i > reduced.size || (!scales.nil? && !scales.empty? && scales.find { |scale| scale.include?(:mode) })
          scales = matches(set: reduced)
          if scales.empty?
            reduced.rotate!.last += 12
            reduced.normalize!
          end
          i += 1
        end
        traits = scales.find { |scale| scale.include?(:mode) }
        traits.last unless traits.nil?
      end

      private

      def match_dictionary_level(matches, set, dictionary, keys)
        keys = Array(keys)
        dictionary.each do |key, value|
          if value.kind_of?(Array)
            if set == value
              matches << keys + [key]
            end
          else
            match_dictionary_level(matches, set, value, keys + [key])
          end
        end
      end

      def scale?(options = {})
        set = options.fetch(:set, @set)
        !scale(set: set).nil?
      end

      def reduce(options = {})
        set = options.fetch(:set, @set)
        set.reduce.normalize.uniq.sort
      end

    end

  end

end
