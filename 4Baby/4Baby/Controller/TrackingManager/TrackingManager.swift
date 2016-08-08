//
//  TrackingManager.swift
//  4Baby
//
//  Created by Admin on 08/08/2016.
//  Copyright © 2016 Rivka Schwartz. All rights reserved.
//



//let trigger4 = "childFarFromMeCarSeatNearMeTrigger"


enum TrackingMode {
    case idle
    case started
    case success
    case failed
}

class TrackingManager : NSObject ,ESTTriggerManagerDelegate {
    
    
    let ChildNearableID : String = "54b128ebbc420d35"//"ChildNearableID"
    let CarSeatNearableID : String = "54b128ebbc420d36"//"CarSeatNearableID"
    
    
    let startTriggerID : String = "childInCarSeatNearMeTrigger"
    let successEndTriggerID : String = "childInCarSeatFarFromMeTrigger"
    let failedEndTriggerID : String = "childNearMeCarSeatFarFromMeTrigger"
    
    static let sharedInstance : TrackingManager = TrackingManager()
    let triggerManager = ESTTriggerManager()
    var trackingMode : TrackingMode = .idle
    
    
    override init() {
        super.init()
        
    }
    
    
    
    func  startTracking() -> Void {
        
        //setting the delegate
        self.triggerManager.delegate = self
        
        let childInRule = ESTProximityRule.inRangeOfNearableIdentifier(ChildNearableID)
        let carSeatInRule = ESTProximityRule.inRangeOfNearableIdentifier(CarSeatNearableID)
        let childOutRule = ESTProximityRule.outsideRangeOfNearableIdentifier(ChildNearableID)
        let carSeatOutRule = ESTProximityRule.outsideRangeOfNearableIdentifier(CarSeatNearableID)
        
        
        let startTrigger = ESTTrigger(rules: [childInRule, carSeatInRule], identifier: startTriggerID)
        self.triggerManager.startMonitoringForTrigger(startTrigger)
        
        
        let failedEndTrigger = ESTTrigger(rules: [childOutRule,carSeatOutRule], identifier: failedEndTriggerID)
        self.triggerManager.startMonitoringForTrigger(failedEndTrigger)
        
        
        let successEndTrigger = ESTTrigger(rules: [childInRule,carSeatOutRule], identifier: failedEndTriggerID)
        self.triggerManager.startMonitoringForTrigger(successEndTrigger)

        
        
        
        
    }
    
    func stopTracking() -> Void {
        self.triggerManager.stopMonitoringForTriggerWithIdentifier(startTriggerID)
        self.triggerManager.stopMonitoringForTriggerWithIdentifier(successEndTriggerID)
        self.triggerManager.stopMonitoringForTriggerWithIdentifier(failedEndTriggerID)
    }
    
    
    
    //MARK : ESTTriggerManagerDelegate methods
    
    func triggerManager(manager: ESTTriggerManager, triggerChangedState trigger: ESTTrigger) {
        
        if (trigger.identifier == startTriggerID && trigger.state == true)
        {
            self.trackingMode = .started
        }
        
        if (trigger.identifier == successEndTriggerID && trigger.state == true)
        {
            self.trackingMode = .success
        }
        
        if (trigger.identifier == failedEndTriggerID && trigger.state == true)
        {
            self.trackingMode = .failed
        }
        
        
        
        
        }
    
}