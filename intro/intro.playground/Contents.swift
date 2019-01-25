/*
 Rob Herley
 I pledge my honor that I have abided by the Stevens Honor System.
*/

import Foundation

// Simple extension for Double to pretty print monetary value
extension Double {
    var cash : String {
        return String(format: "$%.2f", self)
    }
}

// First Exercise
func one() {
    var loan = 1000.0
    var month = 1
    func bal() {
        print("| Month \(month) | Balance: \(loan.cash)")
    }

    while loan > 0 {
        loan += loan * (loan > 500 ? 0.02 : 0.01)
        if loan > 100 {
            loan -= 100
            bal()
        } else {
            let last = loan
            loan = 0
            bal()
            print("=> Last Payment: \(last.cash)")
            print("=> Number of Months: \(month)")
        }
        month += 1
    }
}

print("|--- Exercise One ---|")
one()
print("\n")

// Second Exercise
func two() {
    let weather = Int.random(in: 20...120)
    let schedule = Int.random(in: 0...5)
    let running = Int.random(in: 0...10)
    print("| LikeRunning: \(running) | Schedule: \(schedule) | Weather: \(weather) |")
    if (running >= 4) && (schedule <= 2) && (weather > 45 && weather < 90) {
        print("Going for a Run")
    } else {
        print("Not Going for a Run")
    }
}

print("|--- Exercise Two ---|")
two()
print("\n")

// Third Exercise
func three() {
    let friends = [
        "Elena": 341,
        "Thomas": 273,
        "Hamilton": 278,
        "Suzie": 329,
        "Phil": 445,
        "Matt": 402,
        "Alex": 388,
        "Emma": 275,
        "John": 243,
        "James": 334,
        "Jane": 412,
        "Emily": 393,
        "Daniel": 299,
        "Neda": 343,
        "Aaron": 317,
        "Kate": 265
    ]
    // Ref: https://developer.apple.com/documentation/swift/dictionary/2296181-max
    let fastest = friends.max { a, b in a.value < b.value }
    print("Fastest Runner: \(fastest!.key), Time: \(fastest!.value)")
}

print("|--- Exercise Three ---|")
three()
print("\n")
