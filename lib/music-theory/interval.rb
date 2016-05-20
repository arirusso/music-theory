module MusicTheory

  class Interval

    def self.map(notes)
      numbers = notes.map { |note| note.midi_note_num || note.interval_above_c }
      reduced_members = Scale::Degree.collapse_all(numbers)
      Scale::Degree.normalize(reduced_members)
    end

  end
end
