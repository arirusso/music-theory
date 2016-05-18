module MusicTheory

  module Chord

    class Analysis

      ATTRIBUTES = {
        :major => [0,4],
        :minor => [0,3],
        :diminished => [0,3,5],
        :augmented => [0,4,7],
        :minor_seventh => [0,10],
        :major_seventh => [0,11]
      }.freeze

      INVERSION = {
        [0] => 0,
        [3, 4] => 1,
        [5, 7] => 2,
        [10, 11] => 3
      }.freeze

      attr_reader :members

      def self.find(*args)
        new(*args)
      end

      def initialize(*args)
        @members = args
      end

      def has_attribute?(name)
        attribute = ATTRIBUTES[name.to_sym]
        case attribute
        when Proc then attribute.call(self)
        else (attribute & abs_members) == attribute
        end
      end

      def attributes
        ATTRIBUTES.keys.select { |name| has_attribute?(name) }
      end

      def inversion
        key = INVERSION.keys.find { |k| k.include?(abs_members.first) }
        INVERSION[key]
      end

      def abs_members
        collapsed_members = self.class.collapsed(@members)
        self.class.normalized(collapsed_members)
      end

      def self.collapsed(collection)
        collection.map { |m| m % 12 }
      end

      def self.normalized(collection)
        collection.map { |m| m - collection.min }
      end

    end

  end

end
