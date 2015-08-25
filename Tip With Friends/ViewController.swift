//
//  ViewController.swift
//  Tip With Friends
//
//  Created by Mathew Kellogg on 8/23/15.
//  Copyright (c) 2015 Mathew Kellogg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var friendStepper: UIStepper!
    @IBOutlet weak var friendLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        var defaults = NSUserDefaults.standardUserDefaults()
        
        // Check if it is the first launch and set the default settings if it is
        if !defaults.boolForKey("FirstLaunch") {
            defaults.setDouble(0.15, forKey: "tipOption1")
            defaults.setDouble(0.20, forKey: "tipOption2")
            defaults.setDouble(0.25, forKey: "tipOption3")
            defaults.setInteger(3, forKey: "defaultFriends")
            defaults.setObject("30.00", forKey: "defaultBalance")
            defaults.setObject(NSDate(), forKey: "lastRedraw")
            defaults.synchronize()
        }
        
        // Set fields with defaults
        friendStepper.minimumValue = 1
        redrawDefaults()
        redrawUI()
    }

    @IBAction func onEditingStart(sender: AnyObject) {
        billField.text = ""
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func onFriendsChanged(sender: AnyObject) {
        redrawUI()
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        redrawUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        redrawDefaults()
        redrawUI()
    }
    
    func redrawDefaults(){
        
        var defaults = NSUserDefaults.standardUserDefaults()
        
        billField.text = defaults.objectForKey("defaultBalance")?.description
        friendStepper.value = Double(defaults.integerForKey("defaultFriends"))
        tipControl.setTitle(String(format: "%0.f%%", defaults.doubleForKey("tipOption1") * 100), forSegmentAtIndex: 0)
        tipControl.setTitle(String(format: "%0.f%%", defaults.doubleForKey("tipOption2") * 100), forSegmentAtIndex: 1)
        tipControl.setTitle(String(format: "%0.f%%", defaults.doubleForKey("tipOption3") * 100), forSegmentAtIndex: 2)
        
    }
    
    func redrawUI(){
    
        var defaults = NSUserDefaults.standardUserDefaults()
        
        var lastRedraw = defaults.objectForKey("lastRedraw") as! NSDate
        if NSDate().timeIntervalSinceDate(lastRedraw) > 600 {
            redrawDefaults()
        }
        
        var billAmount = billField.text._bridgeToObjectiveC().doubleValue
        var friendAmount = friendStepper.value
        var tipPercentages = [defaults.doubleForKey("tipOption1"),
                              defaults.doubleForKey("tipOption2"),
                              defaults.doubleForKey("tipOption3")]
        var tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        var tip = billAmount * tipPercentage
        var total = (billAmount + tip) / friendAmount
        
        friendLabel.text = Int(friendStepper.value).description
        totalLabel.text = String(format: "$%.2f", total)
    }
}

