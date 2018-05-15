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
    let colors = Colors()
    private var actualNumber = 0
    private var countGuesses = 0
    private var guessAgain = false
    
    @IBOutlet weak var guessText: UITextField!
    @IBOutlet weak var guessLabel: UILabel!
    
    @IBAction func guessTheNum(_ sender: Any) {
        
        if guessAgain {
            countGuesses = 0
            guessText.text = ""
            actualNumber = Int(arc4random_uniform(100))
            guessAgain = false
        }
        
        if (Int(guessText.text!) != nil){
            //input is present
            countGuesses += 1
            let number = Int(guessText.text!)
            if number == actualNumber {
                guessLabel.text = "Congrats You Guessed Correctly! It took you \(countGuesses) times. Do you want to Play Again?"
                guessAgain = true
            }else if number! < actualNumber{
                guessLabel.text = "You're a little far off.\n Try going up."
                
            }else if number! > actualNumber{
                
                guessLabel.text = "You're a little far off.\n Try going down."
                
            }
            guessText.text = "";
        }else{
            //player did not enter a number
            guessLabel.text = "Please Enter A Number :)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGradientColors()
        actualNumber = Int(arc4random_uniform(100))
        //reset random value
    }
    
    
    func loadGradientColors() {
        view.backgroundColor = UIColor.clear
        var backgroundLayer = colors.gl
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
    }


    
    
}

class Colors {
    var gl:CAGradientLayer!
    
    init() {
        let colorTop = UIColor(red: 42.0 / 255.0, green: 134.0 / 255.0, blue: 203.0 / 255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 226.0 / 255.0, green: 242.0 / 255.0, blue: 249.0 / 255.0, alpha: 1.0).cgColor
        
        self.gl = CAGradientLayer()
        self.gl.colors = [colorTop, colorBottom]
        self.gl.locations = [0.0, 1.0]
    }
}
