//
//  NumberGame.swift
//  MatchingCards
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
            actualNumber = Int(arc4random_uniform(101))
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
        actualNumber = Int(arc4random_uniform(101))
        //reset random value
    }
    
    override open var shouldAutorotate: Bool {
        return false //disable rotation
    }
    
    
    func loadGradientColors() {
        view.backgroundColor = UIColor.clear
        let backgroundLayer = colors.gl
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
    }


 
}

class Colors {
    /*source : stackoverflow.com/questions/24380535/how-to-apply-gradient-to-background-view-of-ios-swift-app */
    
    var gl:CAGradientLayer!
    
    init() {
        let colorTop = UIColor(red: 72.0 / 255.0, green: 113.0 / 255.0, blue: 222.0 / 255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 46.0 / 255.0, green: 155.0 / 255.0, blue: 180.0 / 255.0, alpha: 1.0).cgColor
        
        self.gl = CAGradientLayer()
        self.gl.colors = [colorTop, colorBottom]
        self.gl.locations = [0.0, 1.0]
    }
}
