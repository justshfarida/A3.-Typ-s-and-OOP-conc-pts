## Task 3: Library Catalog System in Ruby

### Task

Create a library catalog system in Ruby that manages different types of library items (books, DVDs and CDs), demonstrating the main OOP principles: class design, inheritance, encapsulation and polymorphism.

### How to run

The code was written and tested with the online compiler at onlinegdb.com, with the language set to **Ruby**. To run it there, add each `.rb` file from this folder as a separate file in the project (the **+** button next to the file tabs), with `main.rb` as the main file, and press **Run**.

If Ruby is installed locally, it can also be run from the `task3` folder with:

```
ruby main.rb
```

In both cases, `main.rb` loads the other files through `require_relative`.

### Class design

```
            LibraryItem
     (title, author, publication_year)
        /          |          \
     Book         DVD          CD
   (genre,     (genre,      (genre,
    pages)   duration_minutes)  track_count)

Library  --- holds --->  any number of LibraryItem objects
```

**`LibraryItem` (base class)**

- Common properties: `title`, `author`, `publication_year`
- `display_info` prints the common properties
- `item_type` returns the class name (`Book`, `DVD` or `CD`)
- `to_s` returns a short description, e.g. `Inception (2010)`
- `creator_label` (protected) returns `"Author"` and can be changed by subclasses

**Derived classes**

| Class | Extra properties | Specific behavior |
|---|---|---|
| `Book` | `genre`, `pages` (optional) | prints genre and page count |
| `DVD` | `genre`, `duration_minutes` (optional) | `director` method; label shown as "Director" |
| `CD` | `genre`, `track_count` (optional) | `artist` method; label shown as "Artist" |

The test code in the assignment passes the director (Christopher Nolan) and the artist (Queen) in the second position, where a book has its author. So the shared `author` property stores the creator of every item, and `DVD` and `CD` add `director` and `artist` methods that return it under the correct name. The fourth argument is the genre for all three classes, matching the test data (`"Programming"`, `"Science Fiction"`, `"Rock"`).

**`Library`**

| Method | Purpose |
|---|---|
| `add_item(item)` | adds an item to the collection; rejects anything that is not a `LibraryItem` |
| `add_items(items)` | adds a whole list (array) of items at once |
| `remove_item(item)` | removes a specific item |
| `remove_by_title(title)` | finds an item by its title and removes it |
| `display_item(item)` | displays one item of any type |
| `display_all_items` | displays every item in the collection |
| `items` | returns a copy of the collection |

### OOP principles

**Inheritance.** `Book`, `DVD` and `CD` inherit from `LibraryItem` (`class Book < LibraryItem`), so the common properties and methods are written once. Each subclass constructor calls `super(title, author, publication_year)` to let the base class set the common properties, and each `display_info` calls `super` first, so the base class prints the shared details and the subclass only adds its own.

**Encapsulation.** Data is kept in instance variables (`@title`, `@genre`, ...), which Ruby does not allow outside code to access directly. Properties are exposed with `attr_reader` only, so they can be read but not changed. `creator_label` is `protected`, so it is usable within the class hierarchy but not from outside. `Library` keeps its collection in `@items`, which can only be changed through `add_item` and `remove_item`. `add_item` also accepts only `LibraryItem` objects, and `items` returns a copy, so outside code cannot modify the real collection.

**Polymorphism.** `Library#display_item` calls `item.display_info` without checking the item's type:

```ruby
def display_item(item)
  item.display_info
end
```

Ruby runs the `display_info` of the object's actual class, so each item prints in its own format, and `display_all_items` works for a collection of mixed types. A new item type could be added without changing `Library`. The same happens inside the base class: `LibraryItem#display_info` calls `creator_label`, which `DVD` and `CD` override, so the same line prints "Author", "Director" or "Artist" depending on the object.

In Ruby every method is bound dynamically, so no keyword is needed to override a method, unlike C# in Task 2, where dynamic binding requires `virtual` and `override`.

### Output (shortened)

```
Type: Book
Title: Concepts of Programming Languages
Author: Robert Sebesta
Publication Year: 2015
Genre: Programming
------------------------------
Type: DVD
Title: Inception
Director: Christopher Nolan
Publication Year: 2010
Genre: Science Fiction
------------------------------
...
Added: The C Programming Language (1978)
Added: Clean Code (2008)
Added: 1984 (1949)
Cannot add "Just a string": not a library item
Added: Concepts of Programming Languages (2015)
Added: Inception (2010)
Added: A Day at the Races (1976)

=== Library Catalog (6 items) ===
...
Removed: Inception (2010)

=== Library Catalog (5 items) ===
...
```
