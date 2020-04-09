//
//  ViewController.swift
//  SwiftDP_Example
//
//  Created by Madalin Mamuleanu on 09/04/2020.
//  Copyright © 2020 OpenMined. All rights reserved.
//

import UIKit
import Hello

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let a = HelloObjC()
        print(a.hello(": Called from Swift") ?? "")
        
    }


}

