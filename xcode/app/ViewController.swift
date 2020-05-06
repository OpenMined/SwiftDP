//
//  ViewController.swift
//  SwiftDP_Example
//
//  Created by Madalin Mamuleanu on 09/04/2020.
//  Copyright © 2020 OpenMined. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let sandbox = Sandbox()
        print("Running objective-c++ sandbox")
        sandbox.test()

        // test status
        let status = DPStatus.statuskUnknown // 2
        let message = "Test Status"
        if let status = OCDPStatus(status: status, andMessage: message) {
            print("Status Code: \(status.code())")
            print("Status Code: \(String(describing: status.message()))")
        }

    }
}
