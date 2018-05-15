//
//  NumberGame.swift
//  MatchingCards
//
//  Created by Teodora on 5/13/18.
//  Copyright © 2018 Teodora. All rights reserved.
//

import Foundation
import UIKit

class NumberGame: UIViewController {
    
    private var guessNumber = 0
    private var countGuesses = 0
    private var guessAgain = false
    
    @IBOutlet weak var guessText: UITextField!
    @IBOutlet weak var guessLabel: UILabel!
    
    @IBAction func guessTheNum(_ sender: Any) {
        if (Int(guessText.text!) != nil){
            //input is present
            countGuesses += 1
            let number = Int(guessText.text!)
            if number == guessNumber {
                guessLabel.text = "Congrats You Guessed Correctly! It took you \(countGuesses) times to get it right. Do you want to Guess Again?"
            }else if number! < guessNumber{
                guessLabel.text = "You're a little far off. Try going up."
                
            }else if number! > guessNumber{
                
                guessLabel.text = "You're a little far off. Try going down."
                
            }
            guessText.text = "";
        }else{
            //player did not enter a number
            guessLabel.text = "Please Enter A Number :)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guessNumber = Int(arc4random_uniform(100))
    }
    
    
    
}
