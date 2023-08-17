import UIKit

let json = """
  {
    "quote": "The will of man is his happiness.",
    "author": "Friedrich Schiller",
    "category": "happiness"
  }
"""

// String => Data => Quote (디코딩, 역직렬화)
// 키 값이 같이 않다면 디코딩 실패
// 옵셔널을 통해 런타임 오류를 방지할 수는 있다..
struct Quote: Decodable {
    let quoteContent: String?
    let authorName: String?
    let category: String?
}

// String => Data
guard let result = json.data(using: .utf8) else {
    fatalError("ERROR")
}

print(result)
dump(result)

// Data => Quote
// Error handling, Do Try Catch, Meta Type
do {
    let value = try JSONDecoder().decode(Quote.self, from: result)
    print(value)
} catch {
    print(error)
}
