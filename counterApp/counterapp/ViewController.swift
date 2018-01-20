//
//  ViewController.swift
//  counterapp
//
//  Created by Govindarajan Panneerselvam on 1/16/18.
//  Copyright © 2018 Govindarajan Panneerselvam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var number : Int = 0
    @IBAction func perform(_ sender: Any) {
        self.number += 1
        self.label.text = String(number)
        print("Pressed Counter - " + String(number))
    }
    
    @IBAction func reset(_ sender: Any) {
        self.number = 0
        self.label.text = String(number)
        print("Pressed Reset - " + String(number))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

