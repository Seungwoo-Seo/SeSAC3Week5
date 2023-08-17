//
//  LotoManger.swift
//  SeSAC3Week5
//
//  Created by 서승우 on 2023/08/17.
//

import Alamofire
import Foundation

final class LotoManger {

    func fetchData(
        compltion: @escaping () -> ()
    ) {
        let url = URL(string: "")!

        AF.request(url, method: .get).validate()
            .responseDecodable(of: Lotto.self) { response in
                guard let value = response.value else { return }
                print("responseDecodable:", value)
            }
    }

}
