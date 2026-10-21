require_relative 'book'
require_relative 'dvd'
require_relative 'cd'
require_relative 'library'
book = Book.new("Concepts of Programming Languages", "Robert Sebesta", 2015, "Programming")
book.display_info
dvd  = DVD.new("Inception", "Christopher Nolan", 2010, "Science Fiction")
dvd.display_info
cd   = CD.new("A Day at the Races", "Queen", 1976, "Rock")
cd.display_info
puts cd.artist

library=Library.new

# Create a list of books and add it to the library in one call
books = [
  Book.new("The C Programming Language", "Brian Kernighan", 1978, "Programming", 272),
  Book.new("Clean Code", "Robert C. Martin", 2008, "Software Engineering", 464),
  Book.new("1984", "George Orwell", 1949, "Dystopian Fiction", 328)
]
library.add_items(books)

# Only library items can be added
library.add_item("Just a string")

library.add_item(book)
library.add_item(dvd)
library.add_item(cd)

library.display_all_items

# Remove an item and show the updated catalog
library.remove_by_title("Inception")
library.display_all_items
