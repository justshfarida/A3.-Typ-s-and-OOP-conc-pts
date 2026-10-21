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

### File structure

| File | Contents |
|---|---|
| `library_item.rb` | `LibraryItem`, the base class |
| `book.rb` | `Book`, derived from `LibraryItem` |
| `dvd.rb` | `DVD`, derived from `LibraryItem` |
| `cd.rb` | `CD`, derived from `LibraryItem` |
| `library.rb` | `Library`, which stores and manages a collection of items |
| `main.rb` | Test code from the assignment, plus a removal demo |

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
| `add_item(item)` | adds an item to the collection |
| `remove_item(item)` | removes a specific item |
| `remove_by_title(title)` | finds an item by its title and removes it |
| `display_item(item)` | displays one item of any type |
| `display_all_items` | displays every item in the collection |
| `items` | returns a copy of the collection |

