## Task 2: Static and Dynamic Binding in C#

### Task

Write a C# program that demonstrates dynamic and static binding in OOP, using the `virtual`, `new` and `override` keywords.

### How to run

From the `task2` folder:

```
dotnet run
```

Or paste `Program.cs` into an online compiler such as onlinegdb.com with the language set to C#.

### Implementation

File: `task2/Program.cs`

The program has a base class `Employee` and a derived class `Manager`:

| Method | In `Employee` | In `Manager` | Binding |
|---|---|---|---|
| `CalculateSalary()` | `virtual`, returns the base salary | `override`, returns base salary + bonus | dynamic |
| `GetRole()` | normal method, returns `"Employee"` | `new`, returns `"Manager"` | static |

`Main` creates three variables:

```csharp
Employee e  = new Employee("Aysel", 1000);
Manager  m  = new Manager("Rashad", 1000, 500);
Employee em = new Manager("Leyla", 1000, 500);
```

The third one is the key case: the **declared type** of the variable is `Employee`, but the **actual object** is a `Manager`.

### Output

```
Aysel: Employee, salary 1000
Rashad: Manager, salary 1500
Leyla: Employee, salary 1500
```

### Explanation

**Binding** is the decision about which method body runs when a method is called.

- **Static binding** is decided at **compile time**, based on the **declared type of the variable**.
- **Dynamic binding** is decided at **runtime**, based on the **actual type of the object**.

The two only give different results when a base-class variable refers to a derived-class object, which is the case for `em` (Leyla).

**`virtual` and `override` give dynamic binding.** `CalculateSalary()` is marked `virtual` in `Employee`, which allows derived classes to replace it and tells C# to choose the method at runtime. `Manager` replaces it with `override`. When `em.CalculateSalary()` is called, the program checks the actual object, finds a `Manager`, and runs `Manager`'s version. Leyla therefore correctly receives the bonus: salary **1500**.

**`new` gives static binding.** `GetRole()` is not virtual. `Manager` declares its own `GetRole()` with `new`, which **hides** the base method instead of replacing it. The two methods are unrelated as far as the compiler is concerned. When `em.GetRole()` is called, the compiler looks at the variable's declared type, `Employee`, and calls `Employee`'s version, even though the object is a `Manager`. Leyla's role is therefore reported as **"Employee"**.

For `e` and `m`, the declared type and the object type are the same, so both kinds of binding give the same result.

If `new` were left out, the program would behave the same way, but the compiler would give warning CS0108 that `Manager.GetRole()` hides the inherited member. The `new` keyword states that the hiding is intentional.

### Conclusion

| Call on `em` (declared `Employee`, object `Manager`) | Keyword | Binding | Result |
|---|---|---|---|
| `em.CalculateSalary()` | `virtual` / `override` | dynamic (runtime, object type) | 1500 (Manager's version) |
| `em.GetRole()` | `new` | static (compile time, variable type) | "Employee" (Employee's version) |

`override` is what makes polymorphism work: code written against the base type (`Employee`) still gets the correct behavior for each derived object. `new` breaks that connection, so the result depends on how the object is referenced rather than what it is.
 