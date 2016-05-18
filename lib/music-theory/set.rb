module MusicTheory

  class Set

    extend Forwardable

    attr_reader :members
    def_delegators :@members, :size

    def initialize(*members)
      @members = members
    end

    def interval(degree)
      @members.at(degree - 1)
    end

    def degree(interval)
      @members.index(interval) + 1
    end

    def collapsed
      Scale::Degree.collapsed(@members)
    end

    def normalized
      Scale::Degree.normalized(@members)
    end

  end

end
