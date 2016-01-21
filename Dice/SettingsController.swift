//
//  SettingsController.swift
//  Dice
//
//  Created by Phillip Viau on 1/13/16.
//  Copyright © 2016 Build it Love it. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {

    @IBOutlet var sliderValue: UISlider!
    @IBOutlet var difficultyLabelNumber: UILabel!
    @IBOutlet var difficultyLabelText: UILabel!
    @IBOutlet var playerHealthLabel: UILabel!
    @IBOutlet var computerHealthLabel: UILabel!
    
    
    var DifficultyArray = ["1.0": "Cakewalk", "1.5": "Very Easy", "2.0": "Easy", "2.5": "Easy", "3.0": "Normal", "3.5": "Hard", "4.0": "Hard", "4.5": "Very Hard", "5.0": "Impossible"]

    var difficultyInt:Int = 1
    
    
    override func viewDidLoad() {
        if NSUserDefaults.standardUserDefaults().objectForKey("diff") != nil {
            let diffSaved = (NSUserDefaults.standardUserDefaults().objectForKey("diff")! as? Float)!
            difficulty = diffSaved
            print(difficulty)
            setPlayerHealthLabel()
            //self.uiSlider.value = 2.0
        }
        super.viewDidLoad()
        sliderValue.value = difficulty
        print(difficulty)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        difficulty = roundOneDecimals(sliderValue.value)
        setPlayerHealthLabel()
        
    }
    
    func roundOneDecimals(num: Float) ->Float {
        
        return round(num * 2.0) / 2.0
    }
    
    func roundTwoDecimals(num: Float) ->Float {
        return round(num * 4.0) / 4.0
    }
    
    func roundNoDecimals(num: Float) -> Int{
        return Int(floor(num * 2) / 2)
    }
    
    func setPlayerHealthLabel(){
        
        difficultyInt = Int(difficulty)
        playerHealth = roundNoDecimals(roundTwoDecimals((playerStartingHealth / difficulty) * (5/difficulty)))
        
        computerHealth = roundNoDecimals(roundTwoDecimals((computerStartingHealth * difficulty) * (difficulty/3)))
        NSUserDefaults.standardUserDefaults().setObject(roundOneDecimals(sliderValue.value), forKey: "diff")
        
        
        switch difficulty {
        case 1.0, 2.0, 3.0, 4.0, 5.0:
            difficultyLabelNumber.text = "Difficulty: \(difficultyInt)"
            break;
        default:
            difficultyLabelNumber.text = "Difficulty: \(difficulty)"
        }
        
        
        difficultyLabelText.text = "\(DifficultyArray[String(difficulty)]!)"
        playerHealthLabel.text = "Player Health: \(playerHealth) hp"
        computerHealthLabel.text = "Computer Health: \(computerHealth) hp"
        
        
    }

}