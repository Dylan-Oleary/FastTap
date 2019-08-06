//
//  ViewController.swift
//  Fast-Tap
//
//  Created by Dylan O'Leary on 2019-08-05.
//  Copyright © 2019 Dylan O'Leary. All rights reserved.
//

import UIKit

extension UILabel {
    func textDropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 1, height: 2)
    }
}

extension UIButton {
    func buttonStyles() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 15.0
        self.layer.masksToBounds = false
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = 5
        self.titleLabel?.textDropShadow()
    }
}

class ViewController: UIViewController {
    //MARK:- Model
    var gameModel = Game()
    
    //MARK:- Timers
    var gameTimer : Timer?
    var gameTimeInSeconds = 0
    var readyCountdownTimer : Timer?
    var readyCountdownInSeconds = 0

    //MARK:- Outlets
    @IBOutlet weak var currentScoreLabel: UILabel!
    @IBOutlet weak var gameButton: UIButton!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var readyMessageLabel: UILabel!
    @IBOutlet weak var secondsLeftLabel: UILabel!
    @IBOutlet weak var highScoreTitleLabel: UILabel!
    
    //MARK:- Actions
    @IBAction func startGame(_ sender: Any) {
        if(gameModel.isPlaying == false){
            //Prepare UI
            startGameButton.isEnabled = false
            currentScoreLabel.text = String(gameModel.currentScore)
            readyMessageLabel.text = "Ready..."
            
            //Begin Countdown to prepare User to tap
            readyCountdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(runReadyCountdownTimer), userInfo: nil, repeats: true)
        }
    }

    @IBAction func incrementScore(_ sender: Any) {
        if(gameModel.isPlaying == true){
            gameModel.setCurrentScore()
            currentScoreLabel.text = String(gameModel.currentScore)
        }
    }
    
    //MARK:- Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set BG Image
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background.png")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview((backgroundImage), at: 0)
        
        //Style Labels
        currentScoreLabel.textDropShadow()
        highScoreLabel.textDropShadow()
        readyMessageLabel.textDropShadow()
        secondsLeftLabel.textDropShadow()
        highScoreTitleLabel.textDropShadow()
        
        //Style Buttons
        gameButton.buttonStyles()
        startGameButton.buttonStyles()
        
        // Do any additional setup after loading the view.
        highScoreLabel.text = String(gameModel.highScore)
        gameButton.isEnabled = false
    }
    
    @objc func runReadyCountdownTimer(){
        if(readyCountdownInSeconds > 0 && readyCountdownInSeconds < 4){
            if(readyCountdownInSeconds == 1){
                readyMessageLabel.text = "3..."
            }
            if(readyCountdownInSeconds == 2){
                readyMessageLabel.text = "2..."
            }
            if(readyCountdownInSeconds == 3){
                readyMessageLabel.text = "1..."
            }
        }
        if(readyCountdownInSeconds == 4){
            readyMessageLabel.text = "Go!"
            secondsLeftLabel.text = "5 Seconds Left"
            //Clean up countdown timer
            readyCountdownTimer?.invalidate()
            readyCountdownInSeconds = 0
            
            //Ready Game For Start
            gameButton.isEnabled = true
            gameModel.startGame()
            gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(runGameTimer), userInfo: nil, repeats: true)
        }
        
        readyCountdownInSeconds += 1
    }
    
    @objc func runGameTimer(){
        gameTimeInSeconds += 1
        
        switch(gameTimeInSeconds){
            case 1 :
                secondsLeftLabel.text = "4 Seconds Left"
            case 2 :
                secondsLeftLabel.text = "3 Seconds Left"
            case 3 :
                secondsLeftLabel.text = "2 Seconds Left"
            case 4 :
                secondsLeftLabel.text = "1 Second Left"
            case 5 :
                secondsLeftLabel.text = ""
            default :
                secondsLeftLabel.text = ""
        }
        
        if gameTimeInSeconds == gameModel.timeLimit {
            //Clean up game timer
            gameTimer?.invalidate()
            gameModel.endGame()
            gameTimeInSeconds = 0
            
            //Clean up UI
            highScoreLabel.text = String(gameModel.highScore)
            readyMessageLabel.text = gameModel.userMessage
            gameButton.isEnabled = false
            startGameButton.isEnabled = true
            secondsLeftLabel.text = ""
        }
    }
}

