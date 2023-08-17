//
//  WeatherManager.swift
//  SeSAC3Week5
//
//  Created by 서승우 on 2023/08/17.
//

import Alamofire
import SwiftyJSON
import Foundation

final class WeatherManager {

    static let shared = WeatherManager()

    private init() {}

    func fetchDataString(
        completion: @escaping (String, String) -> ()
    ) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=737dab703dbed7e4ab93d206033f01d6")!

        AF
            .request(url, method: .get)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let temp = json["main"]["temp"].doubleValue - 273.15
                    let humidity = json["main"]["humidity"].intValue

                    completion("\(temp)도 입니다", "\(humidity)% 입니다")

                case .failure(let error):
                    print(error)
                }
            }
    }

    func fetchDataJSON(
        completion: @escaping (JSON) -> ()
    ) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid=737dab703dbed7e4ab93d206033f01d6")!

        AF
            .request(url, method: .get)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    completion(json)

                case .failure(let error):
                    print(error)
                }
            }
    }

    func fetchDataWeather(
        success: @escaping (WeatherContainer) -> (),
        failure: @escaping (Error) -> ()
    ) {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=1&lon=1&appid=737dab703dbed7e4ab93d206033f01d6"

        AF
            .request(url, method: .get)
            .validate(statusCode: 200...500)
            .responseDecodable(
                of: WeatherContainer.self
            ) { response in
                switch response.result {
                case .success(let value): success(value)
                case .failure(let error): failure(error)
                }
            }
    }

}
