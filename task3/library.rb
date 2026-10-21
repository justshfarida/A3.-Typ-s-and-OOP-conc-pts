require_relative 'library_item'

class Library
  def initialize
    @items = []
  end

  def add_item(item)
    @items << item
    puts "Added: #{item}"
  end

  def remove_item(item)
    if @items.delete(item)
      puts "Removed: #{item}"
    else
      puts "Item not found: #{item}"
    end
  end

  def remove_by_title(title)
    item = nil
    @items.each do |i|
      if i.title == title
        item = i
        break
      end
    end
     if item
        remove_item(item)
      else
        puts "No item titled '#{title}'"
      end
  end

  # Polymorphism: works for any LibraryItem subclass
  def display_item(item)
    item.display_info
  end

  def display_all_items
    if @items.empty?
      puts "The library is empty."
      return
    end
    puts "\n=== Library Catalog (#{@items.size} items) ==="
    @items.each { |item| display_item(item) }
  end

  def items
    @items.dup # read-only copy, protects the internal array
  end
end