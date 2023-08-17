//: [Previous](@previous)

import Foundation

let json = """
  {
    "quote_content": "The will of man is his happiness.",
    "author_name": "Friedrich Schiller",
    "likelike": 34567
  }
"""

// String => Data => Quote (디코딩, 역직렬화)
// 키 값이 같이 않다면 디코딩 실패
// 옵셔널을 통해 런타임 오류를 방지할 수는 있다..
struct Quote: Decodable {
    let content: String
    let name: String
    let like: Int

    enum CodingKeys: String, CodingKey {
        case content = "quote_content"
        case name = "author_name"
        case like = "likelike"
    }
}

// String => Data
guard let result = json.data(using: .utf8) else {
    fatalError("ERROR")
}

print(result)
dump(result)

// Data => Quote
// Error handling, Do Try Catch, Meta Type

// 디코딩 전략
let decoder = JSONDecoder()
do {
    let value = try decoder.decode(Quote.self, from: result)
    print(value)
} catch {
    print(error)
}

//: [Next](@next)
