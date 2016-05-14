module MusicTheory

  class Scale

    attr_reader :degrees, :name

    def initialize(name, *degrees)
      @name, @degrees = name, degrees
    end

    def interval(degree)
      @degrees.at(degree - 1)
    end

    def degree(interval)
      @degrees.index(interval) + 1
    end

    def triad(degree)
    end

    def triads
    end

    def triad_includes?(degree)
    end

  end

end
