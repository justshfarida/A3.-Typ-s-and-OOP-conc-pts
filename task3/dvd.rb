require_relative 'library_item'

class DVD < LibraryItem
  attr_reader :genre, :duration_minutes

  def initialize(title, director, publication_year, genre, duration_minutes = nil)
    super(title, director, publication_year)
    @genre = genre
    @duration_minutes = duration_minutes
  end

  def director
    author
  end

  def display_info
    super
    puts "Genre: #{genre}"
    puts "Duration: #{duration_minutes} min" if duration_minutes
    puts "-" * 30
  end

  protected

  def creator_label
    "Director"
  end
end