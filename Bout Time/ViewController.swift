//
//  ViewController.swift
//  Bout Time
//
//  Created by Ty Schenk on 12/17/16.
//  Copyright © 2016 Ty SchenkTy Schenk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

//Connectors
    @IBOutlet weak var firstDownButton: UIButton!
    @IBOutlet weak var secondUpButton: UIButton!
    @IBOutlet weak var secondDownButton: UIButton!
    @IBOutlet weak var thirdUpButton: UIButton!
    @IBOutlet weak var thirdDownButton: UIButton!
    @IBOutlet weak var fourthUpButton: UIButton!
    @IBOutlet weak var playAgain: UIButton!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet var views: [UIView]!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var firstTap: UITapGestureRecognizer!
    @IBOutlet var secondTap: UITapGestureRecognizer!
    @IBOutlet var thirdTap: UITapGestureRecognizer!
    @IBOutlet var fourthTap: UITapGestureRecognizer!
    
    var timer: Timer = Timer()
    var timeLeft = true
    var time = 0
    var round: Round!
    var roundsPlayed = 0
    var score = 0
    var firstTime = true
    let roundTime: Int = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set the base for the game.
        playAgain.imageView?.contentMode = .scaleAspectFit
        playAgain.isHidden = true
        wordLabel.text = "Sort programing languages based on the date it was founded. Shake to submit"
        wordLabel.numberOfLines = 0
        timeLabel.text = String(roundTime - time)
        round = setupRound()
        startRound(round: round)
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if timeLeft {
            switch sender {
            case fourthUpButton:
                let currentText = fourthLabel.text
                let aboveText = thirdLabel.text
                fourthLabel.text = aboveText
                thirdLabel.text = currentText
            case secondUpButton:
                let currentText = secondLabel.text
                let aboveText = firstLabel.text
                secondLabel.text = aboveText
                firstLabel.text = currentText
            case thirdUpButton:
                let currentText = thirdLabel.text
                let aboveText = secondLabel.text
                thirdLabel.text = aboveText
                secondLabel.text = currentText
            case firstDownButton:
                let currentText = firstLabel.text
                let belowText = secondLabel.text
                firstLabel.text = belowText
                secondLabel.text = currentText
            case secondDownButton:
                let currentText = secondLabel.text
                let belowText = thirdLabel.text
                secondLabel.text = belowText
                thirdLabel.text = currentText
            case thirdDownButton:
                let currentText = thirdLabel.text
                let belowText = fourthLabel.text
                thirdLabel.text = belowText
                fourthLabel.text = currentText
            default:
                print("Clearly something is not right. Hmmm")
                
            }
        }
    }
    
    func startTimer() {
        // Starts the timer.
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
        
    }
    
    func updateTimer() {
        // Updates the timer 
        time += 1
        timeLabel.text = String(roundTime - time)
        
        if time == 60 {
            //Time is up. Stop the Timer and end the round.
            timer.invalidate()
            roundEnd()
        }
    }
    
    func roundEnd() {
        // disable buttons and enable taps
        roundsPlayed += 1
        timeLeft = false
        firstTap.isEnabled = true
        secondTap.isEnabled = true
        thirdTap.isEnabled = true
        fourthTap.isEnabled = true
        //check the score, play sounds and set images
        if round.correctOrder[0].name == firstLabel.text && round.correctOrder[1].name == secondLabel.text && round.correctOrder[2].name == thirdLabel.text && round.correctOrder[3].name == fourthLabel.text {
            print("Answer is correct!")
            showAlert(title: "Answer is correct!")
            score += 1
            if roundsPlayed != 6 {
                playAgain.setImage(UIImage(named: "next_round_success") , for: .normal)
            } else {
                playAgain.setImage(UIImage(named: "play_again"), for: .normal)
            }
            playSound(path: Bundle.main.path(forResource: "CorrectDing", ofType: "wav")!)
            playAgain.isHidden = false
        } else {
            print("Answer is incorrect!")
            showAlert(title: "Answer is incorrect!")
            if roundsPlayed != 6 {
                playAgain.setImage(UIImage(named: "next_round_fail"), for: .normal)
            } else {
                playAgain.setImage(UIImage(named: "play_again"), for: .normal)
            }
            playSound(path: Bundle.main.path(forResource: "IncorrectBuzz", ofType: "wav")!)
            playAgain.isHidden = false
        }
        wordLabel.text = "Click the names for more info."
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        // Test the shake of the device, stop the timer and end the round
        if motion == .motionShake {
            timer.invalidate()
            roundEnd()
        }
    }
    
    @IBAction func nextButton(_ sender: Any) {
        // Check if the game needs ended or if a new round needs to start
        if playAgain.image(for: .normal) == UIImage(named: "play_again") {
            // End the game
            for view in views {
                view.isHidden = true
            }
            scoreLabel.isHidden = false
            if firstTime {
                scoreLabel.text = "Final Score: \(score) out of 6. \n Good luck next time!"
                firstTime = false
            } else {
                score = 0
                roundsPlayed = 0
                usedEvents.removeAll()
                round = setupRound()
                print("round setup")
                startRound(round: round)
            }
        } else {
            // start round
            round = setupRound()
            startRound(round: round)
        }
    }
    
    @IBAction func viewTaps(_ sender: UITapGestureRecognizer) {
        // switch based on what view is tapped
        switch sender {
        case firstTap:
            var url: String {
                var returnable: String = ""
                for event in events {
                    if event.name == firstLabel.text {
                        returnable = event.url
                    }
                }
                return returnable
            }
            let sendingData = ["url": url, "title":firstLabel.text]
            performSegue(withIdentifier: "showWebView", sender: sendingData)
        case secondTap:
            var url: String {
                var returnable: String = ""
                for event in events {
                    if event.name == secondLabel.text {
                        returnable = event.url
                    }
                }
                return returnable
            }
            let sendingData = ["url": url, "title":secondLabel.text]
            performSegue(withIdentifier: "showWebView", sender: sendingData)
        case thirdTap:
            var url: String {
                var returnable: String = ""
                for event in events {
                    if event.name == thirdLabel.text {
                        returnable = event.url
                    }
                }
                return returnable
            }
            let sendingData = ["url": url, "title":thirdLabel.text]
            performSegue(withIdentifier: "showWebView", sender: sendingData)
        case fourthTap:
            var url: String {
                var returnable: String = ""
                for event in events {
                    if event.name == fourthLabel.text {
                        returnable = event.url
                    }
                }
                return returnable
            }
            let sendingData = ["url": url, "title":fourthLabel.text]
            performSegue(withIdentifier: "showWebView", sender: sendingData)
        default:
            print("Clearly something is not right. Hmmm")
        }
    }
    
    // Starts a new round.
    func startRound(round: Round) {
        // disable taps and setup the game
        firstTap.isEnabled = false
        secondTap.isEnabled = false
        thirdTap.isEnabled = false
        fourthTap.isEnabled = false
        time = 0
        timeLeft = true
        firstTime = true
        timeLabel.text = String(roundTime - time)
        wordLabel.text = "Sort programing languages based on the date it was founded. Shake to submit."
        playAgain.isHidden = true
        scoreLabel.isHidden = true
        for view in views {
            view.isHidden = false
        }
        let eventOptions = [round.firstQuestion.name, round.secondQuestion.name, round.thirdQuestion.name, round.fourthQuestion.name]
        print("Answer Key:")
        for answer in round.correctOrder {
            print("\(answer.name) - \(answer.year)")
        }
        var used: [Int] = []
        var randomNumber = randomNumberGenerator(usedNumbers: used, max: eventOptions.count)
        used.append(randomNumber)
        firstLabel.text = eventOptions[randomNumber]
        randomNumber = randomNumberGenerator(usedNumbers: used, max: eventOptions.count)
        used.append(randomNumber)
        secondLabel.text = eventOptions[randomNumber]
        randomNumber = randomNumberGenerator(usedNumbers: used, max: eventOptions.count)
        used.append(randomNumber)
        thirdLabel.text = eventOptions[randomNumber]
        randomNumber = randomNumberGenerator(usedNumbers: used, max: eventOptions.count)
        used.append(randomNumber)
        fourthLabel.text = eventOptions[randomNumber]
        startTimer()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWebView" {
            let data = sender as! [String: String]
            let detail = segue.destination as! WebView
            detail.objectTitle = data["title"]
            detail.url = data["url"]
        }
    }

    func showAlert(title: String, message: String? = nil, style: UIAlertControllerStyle = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

