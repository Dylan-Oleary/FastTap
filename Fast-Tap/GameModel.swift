//
//  GameModel.swift
//  Fast-Tap
//
//  Created by Dylan O'Leary on 2019-08-05.
//  Copyright © 2019 Dylan O'Leary. All rights reserved.
//

import Foundation

class Game {
    var currentScore = 0
    var highScore = 0
    var isPlaying: Bool?
    let timeLimit = 5
    var userMessage = ""
    
    init(){
        isPlaying = false
    }
    
    
    func startGame(){
        isPlaying = true
    }

    func endGame(){
        isPlaying = false
        if(currentScore > highScore){
            setHighScore(score: currentScore)
            userMessage = "New High Score! Congratulations!"
        } else {
            userMessage = "Game Over!"
        }
        currentScore = 0
    }
    
    func setCurrentScore(){
        currentScore = currentScore + 1
    }
        
    func setHighScore(score: Int){
        highScore = score
    }
    
    func getHighScore() -> Int {
        return highScore
    }
}
