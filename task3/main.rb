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
library.add_item(book)
library.add_item(dvd)
library.add_item(cd)

library.display_all_items

# Remove an item and show the updated catalog
library.remove_by_title("Inception")
library.display_all_items
