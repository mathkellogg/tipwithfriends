//
//  OtherViewController.swift
//  
//
//  Created by Mathew Kellogg on 8/24/15.
//
//

import UIKit

class OtherViewController: UIViewController {

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var friendField: UITextField!
    @IBOutlet weak var option1Field: UITextField!
    @IBOutlet weak var option2Field: UITextField!
    @IBOutlet weak var option3Field: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var defaults = NSUserDefaults.standardUserDefaults()
        billField.text = defaults.objectForKey("defaultBalance")?.description
        friendField.text = defaults.integerForKey("defaultFriends").description
        option1Field.text = (defaults.doubleForKey("tipOption1") * 100).description
        option2Field.text = (defaults.doubleForKey("tipOption2") * 100).description
        option3Field.text = (defaults.doubleForKey("tipOption3") * 100).description
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapBack(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        var defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setObject(billField.text, forKey: "defaultBalance")
        defaults.setInteger(friendField.text.toInt()!, forKey: "defaultFriends")
        defaults.setDouble(option1Field.text._bridgeToObjectiveC().doubleValue / 100, forKey: "tipOption1")
        defaults.setDouble(option2Field.text._bridgeToObjectiveC().doubleValue / 100, forKey: "tipOption2")
        defaults.setDouble(option3Field.text._bridgeToObjectiveC().doubleValue / 100, forKey: "tipOption3")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
