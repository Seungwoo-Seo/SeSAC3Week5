import UIKit

//struct User {
//
//    let name = "고래밥"
//    static let originalName = "JACK"
//}
//
//User.originalName
//User.self.originalName
//// 메타 타입 그 제차는 User.Type, 메타 타입의 값은 dd
//
//let user = User()


// "고래밥" => String
// String = > String.Type

// User() = User
// User -> User.Type
// 메타 타입은 클래스 구조체 열거형 등의 유형 그 자체를 가리킴

//type(of: user.name)
//
//
//type(of: User.originalName)
//// 본 질 적인
//
//
//
//
//
//let num = 8.self


func test(age: Int) {
    let t = String(UnicodeScalar(age)?.value ?? 0)

    let svalue = String(age)
    svalue.split(separator: "")

    print(t)
}

test(age: 65)

