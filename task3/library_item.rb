class LibraryItem
  attr_reader :title, :author, :publication_year

  def initialize(title, author, publication_year)
    @title = title
    @author = author
    @publication_year = publication_year
  end

  def display_info
    puts "Type: #{item_type}"
    puts "Title: #{title}"
    puts "#{creator_label}: #{author}"
    puts "Publication Year: #{publication_year}"
  end

  def item_type
    self.class.name
  end

  def to_s
    "#{title} (#{publication_year})"
  end

  protected

  # Subclasses can override this to rename the "author" field
  def creator_label
    "Author"
  end
end
end