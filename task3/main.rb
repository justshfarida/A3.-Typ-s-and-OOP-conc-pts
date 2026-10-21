require_relative 'book'
require_relative 'dvd'
require_relative 'cd'
require_relative 'library'
book = Book.new("Concepts of Programming Languages", "Robert Sebesta", 2015, "Programming")
book.display_info
dvd  = DVD.new("Inception", "Christopher Nolan", 2010, "Science Fiction")
dvd.display_info
