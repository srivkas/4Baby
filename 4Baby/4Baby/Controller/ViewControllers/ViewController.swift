//
//  ViewController.swift
//  4Baby
//
//  Created by Admin on 08/08/2016.
//  Copyright © 2016 Rivka Schwartz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        TrackingManager.sharedInstance.startTracking()
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    deinit
    {
        TrackingManager.sharedInstance.stopTracking()
    }


}

