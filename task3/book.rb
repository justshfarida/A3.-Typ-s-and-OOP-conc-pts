require_relative 'library_item'

class Book < LibraryItem
  attr_reader :genre, :pages

  def initialize(title, author, publication_year, genre, pages = nil)
    super(title, author, publication_year)
    @genre = genre
    @pages = pages
  end

  def display_info
    super
    puts "Genre: #{genre}"
    puts "Pages: #{pages}" if pages
    puts "-" * 30
  end
end