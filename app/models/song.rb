class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def genre_name=(genre)
    self.genre = Genre.find_or_create_by(name: genre)
  end

  def genre_name
    self.genre.name if self.genre
  end

  def artist_name
    self.artist.name if self.artist
  end

  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end

  def notes_attributes=(attributes)
    attributes.each do |attribute|
      self.notes << Note.find_or_create_by(attribute: attribute)
    end
  end

  def notes_attributes
    ret = []
    self.notes.each do |note|
      ret << note.attribute unless note.attribute.empty?
    end
    ret
  end
end
