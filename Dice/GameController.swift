//
//  GameController.swift
//  Dice
//
//  Created by Phillip Viau on 1/13/16.
//  Copyright © 2016 Build it Love it. All rights reserved.
//

import UIKit

/****** Variables *******/
var playerPoints = 0
var computerPoints = 0
var computerHealth:Int = 1666
var playerHealth:Int = 3000
let playerStartingHealth:Float = 3000.0
let computerStartingHealth:Float = 1000.0


var playerAttackMultiplier = 1
var playerDefenseMultiplier = 0
var playerHealMultiplier = 1
var computerAttackMultiplier = 1
var computerDefenseMultiplier = 0
var computerHealMultiplier = 1
var gameover = false
var winner = "Player"
/****** Variables *******/


/********* Player Stats Variables ***********/
var totalRolls = 0
var playerTotalDamageTaken = 0
var playerTotalHeal = 0
/********* Player Stats Variables ***********/

/********* CPU Stats Variables ***********/
var cpuTotalRolls = 0
var cpuTotalDamageTaken = 0
var cpuTotalHeal = 0
/********* Player Stats Variables ***********/


class GameController: UIViewController {
    
    /********* GameView Health Labels *******/
    @IBOutlet var pointsLabel: UILabel!
    @IBOutlet var healthLabel: UILabel!
    @IBOutlet var computerPointsLabel: UILabel!
    @IBOutlet var computerHealthLabel: UILabel!
    /********* GameView Health Labels *******/
     
     /******** Cost Labels ******/
    @IBOutlet var attackCostLabel: UILabel!
    @IBOutlet var healCostLabel: UILabel!
    @IBOutlet var attackMultiplierCostLabel: UILabel!
    @IBOutlet var defenseMultiplierCostLabel: UILabel!
    @IBOutlet var healMultiplierCostLabel: UILabel!
    /******** Cost Labels ******/
     
     /*********** Images *********/
    @IBOutlet var playerDice: UIImageView!
    @IBOutlet var computerDice: UIImageView!
    
    
    
    
    
    /*********** Images *********/
     
     
     /******** Multiplier Labels ******/
    @IBOutlet var attackMultiplierLabel: UILabel!
    @IBOutlet var defenseMultiplierLabel: UILabel!
    @IBOutlet var healMultiplierLabel: UILabel!
    
    @IBOutlet var computerAttackMultiplierLabel: UILabel!
    @IBOutlet var computerHealMultiplierLabel: UILabel!
    @IBOutlet var computerDefenseMultiplierLabel: UILabel!
    
    /******** Multiplier Labels ******/
    

     /******** Player Variables *******/
    let baseAttackCost = 5
    let baseHealCost = 8
    let baseIncreaseAttackCost = 2
    let baseIncreaseDefenseCost = 2
    let baseIncreaseHealCost = 3
    var attackCost = 5
    var healCost = 8
    var increaseAttackCost = 2
    var increaseDefenseCost = 1
    var increaseHealCost = 3
    
    /******** Player Variables *******/
     
     
    /******** Computer Variables *******/
    let baseAttackCostComputer = 5
    let baseHealCostComputer = 8
    let baseIncreaseAttackCostComputer = 2
    let baseIncreaseDefenseCostComputer = 2
    let baseIncreaseHealCostComputer = 3
    var attackCostComputer = 5
    var healCostComputer = 8
    var increaseAttackCostComputer = 2
    var increaseDefenseCostComputer = 1
    var increaseHealCostComputer = 3
     /******** Computer Variables *******/
     
     
     /******* Action Buttons *********/
    @IBOutlet var attackButton: UIButton!
    @IBOutlet var healButton: UIButton!
    @IBOutlet var increaseDefenseButton: UIButton!
    @IBOutlet var increaseAttackButton: UIButton!
    @IBOutlet var increaseHealButton: UIButton!
    /******* Action Buttons *********/
    
    
    
    override func viewDidLoad() {
        updateLabels()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    

    
    
    
    /**************** Random Number Generators **********************/
    func randomNumber(min: Int, max: Int) -> Int{
        return min + Int(arc4random_uniform(UInt32(max - min)) + 1)
        
    }
    
    func randomNumber() -> Float {
        let random = (Float(arc4random()) / Float(UINT32_MAX)/4) + 1.0
        print(random)
        return random
    }
     /**************** Random Number Generators **********************/
    
    
    func win(playerWin: Bool) {
        
        if !playerWin {
            winner = "Computer"
        }

        
        
        self.performSegueWithIdentifier("WinView", sender: nil)
        
    }

    
    /*****************   Player Actions   **************************/
    
    func playerRollDice() -> Int{
        let randomMinArray = [3,2,1,1,1] // array that will be determined on users difficulty set
        let randomMaxArray = [6,6,6,5,4] // array that will be determined on users difficulty set
        let die = randomNumber((randomMinArray[Int(difficulty - 1)]), max: (randomMaxArray[Int(difficulty - 1)])) // random with min and max based on user level chosen
        playerDice.image = UIImage(named: "\(die)")
        totalRolls++
        return die
    }
    
    @IBAction func rollDiceActionButton(sender: AnyObject) {
        let die = playerRollDice()
        
        
        
        playerPoints = playerPoints + die
        computerCheckChance()
        updatePlayerPointsLabel()
    }
    
    // Statements ran when attack button pressed
    @IBAction func attackButton(sender: AnyObject) {
        let die = playerRollDice()
        let damage = (die * playerAttackMultiplier - ( computerDefenseMultiplier * die))
        playerPoints = playerPoints - attackCost
        cpuTotalDamageTaken = cpuTotalDamageTaken + damage
        computerHealth = computerHealth - damage
        if(difficulty == 5.0 && playerAttackMultiplier > 1) {

                playerAttackMultiplier--

        }
        cpuTotalDamageTaken = cpuTotalDamageTaken + damage
                updateLabels()
        
    }

    @IBAction func healButton(sender: UIButton) {
        let healed = (playerRollDice() * playerHealMultiplier)
        playerHealth = playerHealth + healed
        playerTotalHeal = playerTotalHeal + healed
        computerCheckChance()
        updateLabels() // func called in every action
        
    }
    
    @IBAction func increaseDefenseButton(sender: UIButton) {
    
        playerPoints = playerPoints - increaseDefenseCost
        playerDefenseMultiplier++
        increaseDefenseCost = roundNoDecimals(Float(increaseDefenseCost) * randomNumber() + randomNumber())

        computerCheckChance()
        updateLabels()
        
    }
    
    @IBAction func increaseAttackButton(sender: UIButton) {
        
        playerPoints = playerPoints - increaseAttackCost
        playerAttackMultiplier++
        increaseAttackCost = roundNoDecimals(Float(increaseAttackCost) * randomNumber() + randomNumber())
        computerCheckChance()
        updateLabels()
        
    }
    
    @IBAction func increaseHealButton(sender: UIButton) {
        
        playerPoints = playerPoints - increaseHealCost
        playerHealMultiplier++
        increaseHealCost = roundNoDecimals(Float(increaseHealCost) * randomNumber() + randomNumber())
        computerCheckChance()
        updateLabels()
        
    }
    
    
    
    
    /*****************   Action Buttons   **************************/
    
    
    // updates all labels with updated variables
    func updateLabels() {
        

        
        updatePlayerPointsLabel()
        
    }
    
    
    /**************************  Computer Actions *****************************/
    
    
    
    func computerCheckChance(){ // func for computer AI Run for every player action
        let chanceRollMin = Int(arc4random_uniform(50))
        let chanceRollMax = chanceRollMin + Int(arc4random_uniform(100))
        let chance  = chanceRollMin + Int(arc4random_uniform(UInt32(chanceRollMax - chanceRollMin)))
        
        
        
        computerAttackPointsCheck(chance)
        /*
        switch(chanceLibrary){
        case _ where chance <= chanceLibrary[0]:
            computerAttackPointsCheck(chance,chanceLibrary)
            break
        case _ where chance <= chanceLibrary[1]:
            computerPointsCheck(chance)
            break
        case _ where chance <= chanceLibrary[2]:
            computerPointsCheck(chance)
            break
        case _ where chance <= chanceLibrary[3]:
            computerPointsCheck(chance)
            break
        case _ where chance <= chanceLibrary[4]:
            computerPointsCheck(chance)
            break
        default:
            computerPointsCheck(chance)
            
        }*/
    }
    


    
    
    // Dice roll for computer
    func computerRollDice() -> Int {
    
        let randomMinArray = [1,2,2,3,3] // array that will be determined on users difficulty set
        let randomMaxArray = [4,4,5,5,6] // array that will be determined on users difficulty set
        let die = randomNumber((randomMinArray[Int(difficulty - 1)]), max: (randomMaxArray[Int(difficulty - 1)])) // random with min and max
        computerDice.image = UIImage(named: "\(die)")
        cpuTotalRolls++
        return die
    }
    
    func computerAttackPointsCheck(chance: Int) {
        let chanceLibrary = ["Attack": 40, "Heal": 60, "Increase Defense": 75, "Increase Attack": 85, "Increase Heal": 99]
        
        if computerPoints >= attackCostComputer && chance <= chanceLibrary["Attack"]! {
            computerAttack(computerRollDice())
        }else if computerPoints >= healCostComputer && chance <= chanceLibrary["Heal"]! {
            computerHeal(computerRollDice())
        }else if computerPoints >= increaseDefenseCostComputer && chance <= chanceLibrary["Increase Defense"]! {
            computerIncreaseDefense()
        }else if computerPoints >= increaseAttackCostComputer && chance <= chanceLibrary["Increase Attack"]! {
            computerIncreaseAttack()
        }else if computerPoints >= increaseHealCostComputer && chance <= chanceLibrary["Increase Heal"]! {
            computerIncreaseHeal()
        }else{
            computerRoll()
        }
    }
    

    
    func computerRoll(){
        computerPoints = computerPoints + computerRollDice()
    }
    
    func computerAttack(roll: Int){
        let damage = (roll * computerAttackMultiplier - ( playerDefenseMultiplier * roll))
        playerHealth = playerHealth - damage
        playerTotalDamageTaken = playerTotalDamageTaken + damage
        
        computerPoints = computerPoints - attackCost
        if(difficulty == 5.0 && computerAttackMultiplier > 1) {
            
            computerAttackMultiplier--
            
        }
    }
    
    func computerHeal(roll: Int){
        let heal = (roll * computerHealMultiplier)
        computerHealth = computerHealth + heal
        cpuTotalHeal = cpuTotalHeal + heal
        
        computerPoints = computerPoints - healCostComputer
        
    }
    
    func computerIncreaseDefense(){
        computerDefenseMultiplier++
        
        computerPoints = computerPoints - increaseDefenseCostComputer
        increaseDefenseCostComputer = roundNoDecimals(Float(increaseDefenseCostComputer) * randomNumber() + randomNumber())
        
    }
    
    func computerIncreaseAttack(){
        computerAttackMultiplier++
        
        computerPoints = computerPoints - increaseAttackCostComputer
        increaseAttackCostComputer = roundNoDecimals(Float(increaseAttackCostComputer) * randomNumber() + randomNumber())
        

    }
    
    func computerIncreaseHeal(){
        computerHealMultiplier++
        
        computerPoints = computerPoints - increaseHealCostComputer
        increaseHealCostComputer = roundNoDecimals(Float(increaseHealCostComputer) * randomNumber() + randomNumber())
        

        
    }
    
    
    /**************************  Computer Actions *****************************/
    
    
    
    func updatePlayerPointsLabel(){
        pointsLabel.text = "Points: \(playerPoints)"
        
        if playerHealth > 0 && computerHealth > 0 {
        healthLabel.text = "Health: \(playerHealth) hp"
        computerHealthLabel.text = "Health: \(computerHealth) hp"
        }else if playerHealth <= 0 {
            win(false)
        }else if computerHealth <= 0 {
            win(true)
        }
        
        computerPointsLabel.text = "CPU Points: \(computerPoints)"
        print("CPU Points: \(computerPoints)")
        

        attackCostLabel.text = "\(attackCost)"
        healCostLabel.text = "\(healCost)"
        attackMultiplierCostLabel.text = "\(increaseAttackCost)"
        defenseMultiplierCostLabel.text = "\(increaseDefenseCost)"
        healMultiplierCostLabel.text = "\(increaseHealCost)"
        defenseMultiplierLabel.text = "\(playerDefenseMultiplier)"
        attackMultiplierLabel.text = "\(playerAttackMultiplier)"
        healMultiplierLabel.text = "\(playerHealMultiplier)"
        
        computerAttackMultiplierLabel.text = "\(computerAttackMultiplier)"
        computerHealMultiplierLabel.text = "\(computerHealMultiplier)"
        computerDefenseMultiplierLabel.text = "\(computerDefenseMultiplier)"
        
        
        
        if playerPoints >= attackCost {
            attackButton.enabled = true
            attackButton.backgroundColor = UIColor.blueColor()
        }else if playerPoints < attackCost{
            attackButton.enabled = false
            attackButton.backgroundColor = UIColor.grayColor()
        }
        
        if playerPoints >= healCost {
            healButton.enabled = true
            healButton.backgroundColor = UIColor.blueColor()
        }else if playerPoints < healCost{
            healButton.enabled = false
            healButton.backgroundColor = UIColor.grayColor()
        }
        
        if playerPoints >= increaseDefenseCost {
            increaseDefenseButton.enabled = true
            increaseDefenseButton.backgroundColor = UIColor.blueColor()
        }else if playerPoints < increaseDefenseCost{
            increaseDefenseButton.enabled = false
            increaseDefenseButton.backgroundColor = UIColor.grayColor()
        }
        
        if playerPoints >= increaseAttackCost {
            increaseAttackButton.enabled = true
            increaseAttackButton.backgroundColor = UIColor.blueColor()
        }else if playerPoints < increaseAttackCost{
            increaseAttackButton.enabled = false
            increaseAttackButton.backgroundColor = UIColor.grayColor()
        }
        
        if playerPoints >= increaseHealCost {
            increaseHealButton.enabled = true
            increaseHealButton.backgroundColor = UIColor.blueColor()
        }else if playerPoints < increaseHealCost{
            increaseHealButton.enabled = false
            increaseHealButton.backgroundColor = UIColor.grayColor()
        }

        
        
        
    }
    
}
