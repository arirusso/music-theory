module MusicTheory

  class ChordAnalysis

    ATTRIBUTES = {
      :major => [0,4],
      :minor => [0,3],
      :diminished => [0,3,5],
      :augmented => [0,4,7],
      :major_seventh => [0,11],
      :split_third => [0,3,4]
    }.freeze

    INVERSION = {
      [0] => 0,
      [3, 4] => 1,
      [5, 6] => 2,
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
      ATTRIBUTES.keys.map { |name| name if has_attribute?(name) }.compact
    end

    def inversion
      INVERSION.find { |key, val| key.include?(abs_members.first) }.last
    end

    def abs_members
      ChordAnalysis.normalized(ChordAnalysis.collapsed(@members))
    end

    def self.collapsed(collection)
      collection.map { |m| m % 12 }
    end

    def self.normalized(collection)
      collection.map { |m| m - collection.min }
    end

  end

end
