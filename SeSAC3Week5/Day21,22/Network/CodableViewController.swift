//
//  CodableViewController.swift
//  SeSAC3Week5
//
//  Created by 서승우 on 2023/08/16.
//

import Alamofire
import UIKit

func fetchLottoData() {
    let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1080"

    AF.request(url, method: .get).validate()
        .responseData { response in
            guard let value = response.value else { return }
            print("responseData:", value)
        }


    AF.request(url, method: .get).validate()
        .responseString { response in
            guard let value = response.value else { return }
            print("responseString:", value)
        }

    AF.request(url, method: .get).validate()
        .response { response in
            guard let value = response.value else { return }
            print("response:", value)
        }

    AF.request(url, method: .get).validate()
        .responseDecodable(of: Lotto.self) { response in
            guard let value = response.value else { return }
            print("responseDecodable:", value)
        }

}

struct Lotto: Codable {
    let totSellamnt: Int
    let returnValue, drwNoDate: String
    let firstWinamnt, drwtNo6, drwtNo4, firstPrzwnerCo: Int
    let drwtNo5, bnusNo, firstAccumamnt, drwNo: Int
    let drwtNo2, drwtNo3, drwtNo1: Int
}

struct Translation: Codable {
    let message: Message
}

// MARK: - Message
struct Message: Codable {
    let service, version: String
    let result: Result
    let type: String

    enum CodingKeys: String, CodingKey {
        case service = "@service"
        case version = "@version"
        case result
        case type = "@type"
    }
}

// MARK: - Result
struct Result: Codable {
    let engineType, tarLangType, translatedText, srcLangType: String
}

// 열거형으로 함으로써 컴파일 시 오류 타입 알 수 있음
enum ValidationError: Error {
    case emptyString
    case isNotInt
    case isNotDate
}

final class CodableViewController: UIViewController {
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!

    var resultText = "Apple"

    override func viewDidLoad() {
        super.viewDidLoad()

        WeatherManager.shared.fetchDataWeather(
            success: { container in
                self.tempLabel.text = "\(container.main.temp)"
            },
            failure: { error in
                print("show Alert")
            }
        )

//        WeatherManager.shared.fetchDataString { temp, humidity in
//            self.tempLabel.text = temp
//            self.humidityLabel.text = humidity
//        }
//
//        WeatherManager.shared.fetchDataJSON { json in
//            let temp = json["main"]["temp"].doubleValue - 273.15
//            let humidity = json["main"]["humidity"].intValue
//
//            self.tempLabel.text = "\(temp)도 입니다"
//            self.humidityLabel.text = "\(humidity)% 입니다"
//        }
    }

    @IBAction func didTapCheckButton(_ sender: UIButton) {
        guard let text = dateTextField.text else {return}

        do {
            let result = try validateUserInputError(text: text)
        } catch {
            print("검색 불가")
        }

        let example1 = try! validateUserInputError(text: text)
        let example2 = try? validateUserInputError(text: text)
    }

    func validateUserInputError(text: String) throws -> Bool {
        // 빈 칸일 경우
        guard !text.isEmpty else {
            print("빈 값")
            throw ValidationError.emptyString
        }

        // 숫자 여부
        guard Int(text) != nil else {
            print("숫자 아님")
            throw ValidationError.isNotInt
        }

        // 날짜 형식으로 변환이 되는 지
        guard checkDataFormat(text: text) else {
            print("잘못된 날짜 형식")
            throw ValidationError.isNotDate
        }

        return true
    }

    func checkDataFormat(text: String) -> Bool {
        // 날짜 형식으로 변환이 되는 지
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"

        let result = formatter.date(from: text)

        return result == nil ? false : true
    }


//    func fetchTranslateData(source: String, target: String, text: String) {
//        let url = "https://openapi.naver.com/v1/papago/n2mt"
//        let header: HTTPHeaders = [
//            "X-Naver-Client-Id": Key.clientID,
//            "X-Naver-Client-Secret": Key.clientSecret
//        ]
//        let parameters: Parameters = [
//            "source": source,
//            "target": target,
//            "text": text
//        ]
//
//        AF.request(url, method: .post, parameters: parameters, headers: header)
//            .validate(statusCode: 200...500)
//            .responseDecodable(of: Translation.self) { response in
//
//                guard let value = response.value else { return }
//                self.resultText = value.message.result.translatedText
//
//                print("확인", self.resultText)
//
//                self.fetchTranslate(source: "en", target: "ko", text: self.resultText)
//            }
//    }
//
//    func fetchTranslate(source: String, target: String, text: String) {
//        let url = "https://openapi.naver.com/v1/papago/n2mt"
//        let header: HTTPHeaders = [
//            "X-Naver-Client-Id": Key.clientID,
//            "X-Naver-Client-Secret": Key.clientSecret
//        ]
//        let parameters: Parameters = [
//            "source": source,
//            "target": target,
//            "text": text
//        ]
//
//        AF.request(url, method: .post, parameters: parameters, headers: header)
//            .validate(statusCode: 200...500)
//            .responseDecodable(of: Translation.self) { response in
//
//                guard let value = response.value else { return }
//                self.resultText = value.message.result.translatedText
//
//                print("최종확인", self.resultText)
//            }
//    }

}

private extension CodableViewController {

}

