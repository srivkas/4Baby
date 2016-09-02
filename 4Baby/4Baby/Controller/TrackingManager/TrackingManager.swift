//
//  TrackingManager.swift
//  4Baby
//
//  Created by Admin on 08/08/2016.
//  Copyright © 2016 Rivka Schwartz. All rights reserved.
//



//let trigger4 = "childFarFromMeCarSeatNearMeTrigger"

enum State : String{
    case idle = "idle"
    case started = "started"
    case success = "success"
    case failed = "failed"
}

protocol  TrackingManagerDelegate
{
    func trackingManagerStateDidChanged(oldState:State,newState:State) -> Void
}



class TrackingManager : NSObject ,ESTTriggerManagerDelegate {
    
    var delegate : TrackingManagerDelegate? = nil
    
    let ChildNearableID : String = "8eb948fd938b3984"//"ChildNearableID"
    let CarSeatNearableID : String = "e0d79996bc3c63b0"//"CarSeatNearableID"
    
    
    let startTriggerID : String = "childAndCarSeatNearMeTrigger"
    let failedEndTriggerID : String = "childAndCarSeatFarFromMeTrigger"
    let successEndTriggerID : String = "childNearMeCarSeatFarFromMeTrigger"
    
    static let sharedInstance : TrackingManager = TrackingManager()
    let triggerManager = ESTTriggerManager()
    var trackingMode : State = .idle
    
    
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
        
        
        let successEndTrigger = ESTTrigger(rules: [childInRule,carSeatOutRule], identifier: successEndTriggerID)
        self.triggerManager.startMonitoringForTrigger(successEndTrigger)

        
        
        
        
    }
    
    func stopTracking() -> Void {
        self.triggerManager.stopMonitoringForTriggerWithIdentifier(startTriggerID)
        self.triggerManager.stopMonitoringForTriggerWithIdentifier(successEndTriggerID)
        self.triggerManager.stopMonitoringForTriggerWithIdentifier(failedEndTriggerID)
    }
    
    
    
    //MARK : ESTTriggerManagerDelegate methods
    
    func triggerManager(manager: ESTTriggerManager, triggerChangedState trigger: ESTTrigger) {
        
        let oldState : State = self.trackingMode
        
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
        
        if oldState != self.trackingMode {
            
            self.delegate?.trackingManagerStateDidChanged(oldState, newState: self.trackingMode)
        }
        
        
        
        }
    
}