//
//  winController.swift
//  Dice
//
//  Created by Phillip Viau on 1/14/16.
//  Copyright © 2016 Build it Love it. All rights reserved.
//

import UIKit

class winController: UIViewController {
    
    @IBOutlet var winnerText: UIButton!
    @IBOutlet var label: UILabel!
    
    
    /*********** Game Stats **************/
    //Player
    @IBOutlet var playerTotalRolls: UILabel!
    @IBOutlet var playerTotalDamage: UILabel!
    @IBOutlet var playerTotalHealed: UILabel!
    @IBOutlet var playerAttMultiplier: UILabel!
    //@IBOutlet var playerHealMultiplier: UILabel!
    @IBOutlet var playerDefMultiplier: UILabel!
    //@IBOutlet var playerPoints: UILabel!
    @IBOutlet var playerSpentPoints: UILabel!
    //@IBOutlet var playerPointsLabel: UILabel!
    //@IBOutlet var playerHealMultiplierLabel: UILabel!
    
    
     //Computer
    @IBOutlet var cpuTotalRolls: UILabel!
    @IBOutlet var cpuTotalDamage: UILabel!
    @IBOutlet var cpuTotalHealed: UILabel!
    @IBOutlet var cpuAttMultiplier: UILabel!
    @IBOutlet var cpuDefMultiplier: UILabel!
    @IBOutlet var cpuHealMultiplier: UILabel!
    @IBOutlet var cpuPoints: UILabel!
    @IBOutlet var cpuSpentPoints: UILabel!
     
     
    /*********** Game Stats **************/
    
    
    
    
    
    override func viewDidLoad() {
        label.text = "\(winner) wins"
        playerTotalRolls.text = "\(totalRolls)"
        playerTotalDamage.text = "\(playerTotalDamageTaken)"
        playerTotalHealed.text = "\(playerTotalHeal)"
        playerAttMultiplier.text = "\(playerAttackMultiplier)"
        //playerHealMultiplierLabel.text = "\(playerHealMultiplier)"
        playerDefMultiplier.text = "\(playerDefenseMultiplier)"
        //cpuTotalRolls.text = "\(cpuTotalRolls)"
        cpuTotalDamage.text = "\(cpuTotalDamageTaken)"
        cpuTotalHealed.text = "\(cpuTotalHeal)"
        cpuAttMultiplier.text = "\(computerAttackMultiplier)"
        cpuDefMultiplier.text = "\(computerDefenseMultiplier)"
        cpuHealMultiplier.text = "\(computerHealMultiplier)"
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func back(sender: AnyObject) {
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
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    func roundOneDecimals(num: Float) ->Float {
        
        return round(num * 2.0) / 2.0
    }
    
    internal func roundTwoDecimals(num: Float) ->Float {
        return round(num * 4.0) / 4.0
    }
    
    internal func roundNoDecimals(num: Float) -> Int{
        return Int(floor(num * 2) / 2)
    }
    
}

