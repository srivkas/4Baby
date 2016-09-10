//
//  ViewController.swift
//  4Baby
//
//  Created by Admin on 08/08/2016.
//  Copyright © 2016 Rivka Schwartz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TrackingManagerType1Delegate {

    @IBOutlet weak var statusLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        TrackingManagerType1.sharedInstance.startTracking()
        TrackingManagerType1.sharedInstance.delegate = self
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    deinit
    {
        
        TrackingManagerType1.sharedInstance.stopTracking()
        
    }
    
    
    func TrackingManagerType1StateDidChanged(oldState:State,newState:State) -> Void
    {
       self.statusLabel.text = String(format:"%@->%@",oldState.rawValue,newState.rawValue)
  
    }



}

