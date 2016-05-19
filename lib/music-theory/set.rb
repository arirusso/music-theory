module MusicTheory

  class Set

    extend Forwardable

    attr_reader :members
    def_delegators :@members, :size, :to_a

    def initialize(*members)
      @members = members.flatten
    end

    def interval(degree)
      @members.at(degree - 1)
    end

    def degree(interval)
      @members.index(interval) + 1
    end

    def collapse
      members = Scale::Degree.collapse_all(@members)
      Set.new(members)
    end

    def collapse!
      @members = collapse.members
    end

    def normalize
      members = Scale::Degree.normalize(@members)
      Set.new(members)
    end

    def normalize!
      @members = normalize.members
    end

    def sort
      Set.new(@members.sort)
    end

    def sort!
      @members = sort.members
    end

    def uniq
      Set.new(@members.uniq)
    end

    def uniq!
      @members = uniq.members
    end

    def ==(o)
      (o.class == self.class) && o.members == @members
    end
    alias_method :eql?, :==

  end

end
