//
//  GCDBasicViewController.swift
//  SeSAC3Week5
//
//  Created by jack on 2023/08/14.
//

import UIKit

class GCDBasicViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
        serialSync()
    }

    func globalAsyncTwo() {
        print("Starat")

        for i in 1...100 {
            DispatchQueue.global().async {
                sleep(1)
                print(i, terminator: " ")
            }
        }
    }

    func serialAsync() {
        for i in 1...50 {
            sleep(1)
            print(i, terminator: " ")
        }

        // 무한 대기 상태, 교착 상태(deadlock)
        for i in 101...200 {
            sleep(1)
            print(i, terminator: " ")
        }

    }
    
    func serialSync() {
        print("Start")
        
        for i in 1...50 {
            sleep(1)
            print(i, terminator: " ")
        }

        // 무한 대기 상태, 교착 상태(deadlock)

        for i in 101...200 {
            sleep(1)
            print(i, terminator: " ")
        }

        
        print("End")
    }
}
