//
//  ViewController.swift
//  MatchingCards
//
//  Created by Teodora on 5/1/18.
//  Copyright © 2018 Teodora. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gameView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBAction func resetGame(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //blockMakerAction()
        //randomizeTiles()
        self.resetGame(Any.self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
         // Dispose of any resources that can be recreated.
    }
    
}


