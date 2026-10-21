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


### Explanation

**Expected order in theory: static ≈ stack < heap.**

- **Static** variables are bound to memory once, before execution begins. Calling the function performs no allocation, so the time is below what `clock()` can measure (about 1 ms resolution on Windows).
- **Stack-dynamic** variables are allocated on each call, but allocation is normally a single instruction that moves the stack pointer, so it should be almost as fast as static.
- **Explicit heap-dynamic** variables require `malloc` to find and reserve a free block and `free` to return it. This bookkeeping happens on every call, so the heap is normally the slowest.


**What the measurements show:**

- For a **small array (4 KB)**, the results match the theory: static and stack are both too fast to measure, and heap is the slowest.
- As the array **grows**, the stack time grows with it (0.001 s at 40 KB, 0.022 s at 200 KB, 0.032 s at 400 KB), while the heap time stays flat at about 0.010 s.
- Somewhere between 40 KB and 200 KB, the stack becomes **slower** than the heap.
  **Why the stack becomes slow for large arrays:**

Normally, allocating a local array on the stack costs a single instruction: the stack pointer is moved down by the size of the array. On Windows, large stack frames add an extra cost because of how the stack grows.

*How the Windows stack grows.* Windows reserves the stack (1 MB by default) for each thread but does not back all of it with physical memory at the start. Memory is managed in **pages** of 4 KB. Only the pages already in use are **committed** (backed by real memory). Directly below them is a single **guard page**. When the program touches the guard page, Windows commits it and marks the next page down as the new guard page. The stack can therefore only grow downward one page (4 KB) at a time.


*Why large arrays need probing.* 400 KB array moves the stack pointer down by about 98 pages in one step. If the function then accessed memory below the guard page, it would skip past it and hit memory that is reserved but not committed, causing an access violation. To prevent this, the compiler inserts a call to a helper function, `__chkstk`, at the start of any function whose stack frame is larger than one page. This function **probes** the new stack area by touching each 4 KB page in order, from the top down, so the guard page is reached step by step and every page is committed before the function body runs.


*Why this costs time on every call.* Once a page is committed it stays committed, so the expensive work of committing pages happens only on the first call. However, `__chkstk` cannot know that the pages are already committed, so it still touches every page on every call. The number of probes per call is the array size divided by the page size:

| N (ints) | Array size (bytes) | Pages probed per call |
|---|---|---|
| 1,000 | 4,000 | 0 (smaller than one page, so no `__chkstk`) |
| 10,000 | 40,000 | about 10 |
| 50,000 | 200,000 | about 49 |
| 100,000 | 400,000 | about 98 |

With N = 100,000, that is about 98 probes × 100,000 calls, or roughly 10 million memory accesses, which explains the 0.032 s result. The stack time grows with the array size because the number of probes does.