//
//  UIViewController+.swift
//  SeSAC3Week5
//
//  Created by 서승우 on 2023/08/17.
//

import UIKit

extension UIViewController {
    
    func presentAlert(
        title: String,
        message: String,
        actionTitle: String?,
        completion: @escaping () -> ()
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let action = UIAlertAction(title: actionTitle, style: .default) { action in
            completion()
        }

        [cancel, action].forEach { alert.addAction($0) }

        present(alert, animated: true)
    }

}
