module MusicTheory

  class ChordAnalysis

    ATTRIBUTES = {
      :major => [0,4],
      :minor => [0,3],
      :diminished => [0,3,5],
      :augmented => [0,4,7],
      :major_seventh => [0,11],
      :split_third => [0,3,4]
    }

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
      case abs_members.first
        when 0 then 0
        when 3,4 then 1
        when 5,6 then 2
        when 10,11 then 3
      end
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
