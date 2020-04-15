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

    }

}
