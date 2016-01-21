//
//  InstructionController.swift
//  Dice
//
//  Created by Phillip Viau on 1/14/16.
//  Copyright © 2016 Build it Love it. All rights reserved.
//

import UIKit

class InstructionController: UIViewController {
    

    
    override func viewDidLoad() {
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func back(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
