//
//  ViewController.swift
//  Fun Game
//
//  Created by Ehill_Catalina_VM on 5/11/20.
//  Copyright © 2020 Peaceful Coder. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startGameButton: UIButton!
    
    @IBOutlet weak var goodButton: UIButton!
    @IBOutlet weak var badButton: UIButton!
    @IBOutlet weak var leaderboardButton: UIButton!
    @IBOutlet var pointsLabel: UILabel!
    
    var gameButtons = [UIButton]()
    var gamePoints = 0
    
    enum GameState {
        case gameOver
        case playing
    }
    
    var state = GameState.gameOver
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pointsLabel.isHidden = true
        
        gameButtons = [goodButton, badButton]
        
        setupFreshGameState()
    }

    func startNewGame(){
        startGameButton.isHidden = true
        leaderboardButton.isHidden = true
        gamePoints = 0
        updatePointsLabel(gamePoints)
        pointsLabel.textColor = .magenta
        pointsLabel.isHidden = false
        oneGameRound()
    }
    
    //Game Logic - One Game Round

    func oneGameRound() {
        updatePointsLabel(gamePoints)
        displayRandomButton()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0,
                                     repeats: false) { _ in
        if self.state == GameState.playing {
            if self.currentButton == self.goodButton {
                self.gameOver()
        } else {
            self.oneGameRound()
            
                }
            }
        }
    }

    
    //Game Logic - Start New Game
    @IBAction func startpressed(_ sender: Any) {
        print("Start game button was pressed")
        state = GameState.playing
        startNewGame()
    }
//Game Logic - Good or Bad button pressed
    //Add a point, and update the score when the good button is pressed
    @IBAction func goodpressed(_ sender: Any) {
        gamePoints = gamePoints+1
        updatePointsLabel(gamePoints)
        goodButton.isHidden = true
        timer?.invalidate()
        oneGameRound()
    }
    @IBAction func badpressed(_ sender: Any) {
            badButton.isHidden = true
            timer?.invalidate()
            gameOver()
        }
   
    var timer: Timer?
    var currentButton: UIButton!
    
    func displayRandomButton() {
        for mybutton in gameButtons {
            mybutton.isHidden = true
        }
        let buttonIndex = Int.random(in: 0..<gameButtons.count)
        currentButton = gameButtons[buttonIndex]
        currentButton.center = CGPoint(x: randomXCoordinate(), y: randomYCoordinate())
        currentButton.isHidden = false
    }
    
    func gameOver() {
        state = GameState.gameOver
        pointsLabel.textColor = .brown
        setupFreshGameState()
    }
    
    func setupFreshGameState() {
        startGameButton.isHidden = false
        leaderboardButton.isHidden = false
        for mybutton in gameButtons {
            mybutton.isHidden = true
    }
        pointsLabel.alpha = 0.15
        currentButton = goodButton
        state = GameState.gameOver
}
    
    func randCGFloat(_ min: CGFloat, _max: CGFloat) ->CGFloat
        {
            return CGFloat.random(in: min..._max)
    }

    func randomXCoordinate() -> CGFloat {
        let left = view.safeAreaInsets.left +
            currentButton.bounds.width
        let right = view.bounds.width -
            view.safeAreaInsets.right
        return randCGFloat(left, _max: right)
    }
    
    func randomYCoordinate() -> CGFloat {
        let top  = view.safeAreaInsets.top +
            currentButton.bounds.height
        let bottom = view.bounds.height -
            view.safeAreaInsets.bottom -
            currentButton.bounds.height
        return randCGFloat(top, _max: bottom)
    }
    
    func updatePointsLabel(_ newValue: Int){
        pointsLabel.text = "\(newValue)"
    }
}
