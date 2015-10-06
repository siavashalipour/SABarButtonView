//
//  ViewController.swift
//  SABarButtonView
//
//  Created by Siavash on 10/04/2015.
//  Copyright (c) 2015 Siavash. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tabBar:SABarButtonView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tabBar.btnsTitles = ["View 1","View 2","View 3"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

