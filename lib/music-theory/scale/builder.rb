module MusicTheory

  class Scale

    module Builder

      extend self

      def build(name, type, options = {})
        name = Note.find(name) unless name.kind_of?(Note::Name)
        
      end

    end

  end

end
