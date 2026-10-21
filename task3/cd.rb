require_relative 'library_item'

class CD < LibraryItem
  attr_reader :genre, :track_count

  def initialize(title, artist, publication_year, genre, track_count = nil)
    super(title, artist, publication_year)
    @genre = genre
    @track_count = track_count
  end

  def artist
    author
  end

  def display_info
      super
    puts "Genre: #{genre}"
    puts "Tracks: #{track_count}" if track_count
    puts "-" * 30
  end

  protected

  def creator_label
    "Artist"
  end
end