# A3: Types and OOP Concepts

## Task 1: Static vs. Stack vs. Heap Arrays

### Task

Write three functions in C that create the same large array in three different ways:

- **statically** (`static int arr[N]`)
- **on the stack** (`int arr[N]`)
- **on the heap** (`malloc` / `free`)

Call each function many times (100,000) and measure how long each takes. Explain the results.

### How to build and run

The project uses CMake. Open the folder in CLion, load `CMakeLists.txt`, then select `task1` in the run configuration dropdown and press **Run**.

Or from the command line:

```
cmake -S . -B build
cmake --build build
./build/task1
```

### Implementation

File: `task1/main.c`

| Function | How the array is created |
|---|---|
| `create_array_static()` | `static int arr[N];` is allocated once, when the program loads |
| `create_array_instack()` | `int arr[N];` is allocated on every call by moving the stack pointer |
| `create_array_inheap()` | `malloc(N * sizeof(int))` and `free` run on every call |

Settings:

- `N = 100000` (array of 100,000 ints, about 400 KB)
- `MAX = 100000` (number of calls per function)

Each function writes only `arr[0]`, so the measurement reflects the cost of **creating** the array rather than filling it. Timing uses `clock()` from `<time.h>`.

### Results (100,000 calls per function, Debug build, Windows)

| N (ints) | Array size | Static (s) | Stack (s) | Heap (s) |
|---|---|---|---|---|
| 1,000 | 4 KB | 0.000 | 0.000 | 0.002 |
| 10,000 | 40 KB | 0.000 | 0.001 | 0.010 |
| 50,000 | 200 KB | 0.000 | 0.022 | 0.010 |
| 100,000 | 400 KB | 0.000 | 0.032 | 0.010 |

`clock()` on Windows has a resolution of about 1 ms, so values of 0.000 and 0.001 mean "too fast to measure precisely".