//: [Previous](@previous)

import Foundation

let json = """
  {
    "quote_content": "The will of man is his happiness.",
    "author_name": "Friedrich Schiller"
  }
"""

// String => Data => Quote (디코딩, 역직렬화)
// 키 값이 같이 않다면 디코딩 실패
// 옵셔널을 통해 런타임 오류를 방지할 수는 있다..
struct Quote: Decodable {
    let quoteContent: String
    let authorName: String
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
decoder.keyDecodingStrategy = .convertFromSnakeCase     // 스네이크 케이스 정도는 이렇게 처리 가능

do {
    let value = try decoder.decode(Quote.self, from: result)
    print(value)
} catch {
    print(error)
}


//: [Next](@next)
