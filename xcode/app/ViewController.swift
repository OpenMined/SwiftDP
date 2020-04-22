//
//  ViewController.swift
//  SwiftDP_Example
//
//  Created by Madalin Mamuleanu on 09/04/2020.
//  Copyright © 2020 OpenMined. All rights reserved.
//

import UIKit
import SwiftDP

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let a = SwiftDP_rand().uniformDouble()
        let b = SwiftDP_rand().geometric()

        print(a)
        print(b)

        let sandbox = Sandbox()
        sandbox.test()

        let status = DPStatus.statuskUnknown // 2
        let message = "Test Status"
        let e = SwiftDP_status(status: status, andMessage: message)
        if let e = e {
            print("\nGot the status back: \(e.code())") // 2 statuskUnknown
            print("\nGot the status back: \(e.message())")
            print("\nGot the status back: \(e.toString())")
        }


        let carrots = SwiftDP_CarrotReporter(epsilon: 1)
        print(carrots.getCarrotsData())
        //let dict: Dictionary<String, Int> = ["setting":1, "new dict":2]
        //carrots.setCarrotsData(dict)
        //print(carrots.getCarrotsData())

        print(carrots.sum())
        print(carrots.mean())
        print(carrots.count(above: 1))
        print(carrots.max())
        print(carrots.privacyBudget())
    }

}
