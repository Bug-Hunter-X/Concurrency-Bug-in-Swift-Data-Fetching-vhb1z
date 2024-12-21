# Swift Concurrency Bug: Incomplete Data Fetch
This repository demonstrates a subtle concurrency bug in a Swift function designed to fetch data from multiple URLs. The issue lies in how errors are handled during asynchronous operations.

## Problem
The provided `fetchData` function uses `DispatchGroup` to wait for all network requests to complete. However, the error handling in the `reduce` function is flawed.  If even one URL request fails, the `reduce` operation stops, leading to incomplete data in the final `combinedResult`.

## Solution
The solution involves refining the error handling to collect all errors and return them alongside any successfully fetched data. This allows for more robust handling of partial failures.

## How to reproduce
1. Clone this repo
2. Run `bug.swift` (it will likely fail or have incomplete data).
3. Run `bugSolution.swift` (demonstrates corrected code)