//
//  ViewController.swift
//  Dice
//
//  Created by Phillip Viau on 1/13/16.
//  Copyright © 2016 Build it Love it. All rights reserved.
//

import UIKit
var difficulty:Float = 3.0



class ViewController: UIViewController {

    /******** Settings *********/
    @IBOutlet var difficultyLabelNumber: UILabel!
    @IBOutlet var difficultyLabelText: UILabel!
    @IBOutlet var uiSlider: UISlider!
    @IBOutlet var startingHealthLabel: UILabel!
    @IBOutlet var computerHealthLabel: UILabel!
     /******** Settings *********/
    

    
    
    /****** Variables *******/
    var DifficultyArray = ["1.0": "Cakewalk", "1.5": "Very Easy", "2.0": "Easy", "2.5": "Easy", "3.0": "Normal", "3.5": "Hard", "4.0": "Hard", "4.5": "Very Hard", "5.0": "Impossible"]
    var playerStartingHealth:Float = 3000.0
    var computerStartingHealth:Float = 1000.0
    

    var difficultyInt:Int = 1

    

    
    

/*    @IBAction func uiSliderValue(sender: AnyObject) {
        
        difficulty = roundOneDecimals(uiSlider.value)
        difficultyInt = Int(difficulty)
        
        
        playerHealth = roundNoDecimals(roundTwoDecimals((playerStartingHealth / difficulty) * (5/difficulty)))

        computerHealth = roundNoDecimals(roundTwoDecimals((computerStartingHealth * difficulty) * (difficulty/3)))
        NSUserDefaults.standardUserDefaults().setObject(roundOneDecimals(uiSlider.value), forKey: "diff")
        setPlayerHealthLabel()

        
        
        
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if NSUserDefaults.standardUserDefaults().objectForKey("diff") != nil {
            let diffSaved = (NSUserDefaults.standardUserDefaults().objectForKey("diff")! as? Float)!
            difficulty = diffSaved
            print(difficulty)
            
            //self.uiSlider.value = 2.0
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet var sliderValueSettings: UISlider!
    
    @IBAction func settingsActionButton(sender: AnyObject) {
        
        
        
    }
    

    
    @IBAction func resetButton(sender: UIButton) {
        playerHealth = roundNoDecimals(roundTwoDecimals((playerStartingHealth / difficulty) * (5/difficulty)))
        computerHealth = roundNoDecimals(roundTwoDecimals((computerStartingHealth * difficulty) * (difficulty/3)))
        playerPoints = 0
        computerPoints = 0
        playerAttackMultiplier = 1
        playerDefenseMultiplier = 0
        playerHealMultiplier = 1
        computerAttackMultiplier = 1
        computerDefenseMultiplier = 0
        computerHealMultiplier = 1
        
    }
  
    
    func roundNoDecimals(num: Float) -> Int{
        return Int(floor(num * 2) / 2)
    }
    
    func roundTwoDecimals(num: Float) ->Float {
        return round(num * 4.0) / 4.0
    }



}

