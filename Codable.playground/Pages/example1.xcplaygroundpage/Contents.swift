//: [Previous](@previous)

import Foundation

// Encoding -> Serialization
// Decoding -> Deserialization


let json = """
  {
    "quote": "The will of man is his happiness.",
    "author": "Friedrich Schiller",
    "category": "happiness"
  }
"""

// String => Data => Quote (디코딩, 역직렬화)
struct Quote: Decodable {
    let quote: String
    let author: String
    let category: String
}

// String => Data
guard let result = json.data(using: .utf8) else {
    fatalError("ERROR")
}

print(result)
dump(result)

// Data => Quote
// Error handling, Do Try Catch, Meta Type
// Self / self / String / String.self /
do {
    let value = try JSONDecoder().decode(Quote.self, from: result)
    print(value)
} catch {
    print(error)
}
//: [Next](@next)
