#!/usr/bin/env swift

/*
--- Part Two ---
On the other hand, it might be wise to try a different strategy: let the giant squid win.

You aren't sure how many bingo boards a giant squid could play at once, so rather than waste 
time counting its arms, the safe thing to do is to figure out which board will win last and 
choose that one. That way, no matter which boards it picks, it will win for sure.

In the above example, the second board is the last to win, which happens after 13 is eventually 
called and its middle column is completely marked. If you were to keep playing until this point, 
the second board would have a sum of unmarked numbers equal to 148 for a final score of 148 * 13 = 1924.

Figure out which board will win last. Once it wins, what would its final score be?
*/

// curl -sS -b "session=$AOC_SSID" https://adventofcode.com/2021/day/4/input > input

import Foundation

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map { Array(self[$0 ..< Swift.min($0 + size, count)]) }
    }
}

extension Array where Element == [Int] {
    mutating func mark(_ x: Int) {
        for i in 0..<count {
            for j in 0..<self[i].count {
                if self[i][j] == x {
                    self[i][j] = 0
                    return
                }
            }
        }
    }

    var score: Int {
        reduce(into: 0) { $0 += $1.reduce(0, +) }
    }

    func isBingo(atRow row: Int) -> Bool {
        self[row].first(where: { $0 != 0 }) == nil
    }

    func isBingo(atCol col: Int) -> Bool {
        first(where: { $0[col] != 0 }) == nil
    }

    func isBingo() -> Bool {
        (0 ..< count).first(where: { isBingo(atRow: $0) || isBingo(atCol: $0) }) != nil
    }
}

let file = CommandLine.arguments.dropFirst().first!
let content = try! String(contentsOfFile: file).split(separator: "\n").filter { !$0.isEmpty }

let nums = content.first?.split(separator: ",").compactMap { Int($0) } ?? []
var tables = content.dropFirst().map { $0.split(separator: " ").filter { !$0.isEmpty }.map { Int($0)! }}.chunked(into: 5)

var candidates = Array(0..<tables.count)
var lastTableIndex = 0

for n in nums {
    lastTableIndex = candidates.first ?? 0
    candidates.removeAll(where: { i in
        tables[i].mark(n)
        return tables[i].isBingo()
    })
    if candidates.isEmpty {
        print(tables[lastTableIndex].score * n)
        exit(EXIT_SUCCESS)
    }
}