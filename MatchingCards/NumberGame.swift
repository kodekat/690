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
            
        }else{
            guessLabel.text = "Please Enter A Number :)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guessNumber = Int(arc4random_uniform(100))
    }
    
    
    
}
