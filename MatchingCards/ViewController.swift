//
//  ViewController.swift
//  MatchingCards
//
//  Created by Teodora on 5/1/18.
//  Copyright © 2018 Teodora. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    let colors = Colors()
    @IBOutlet weak var gameView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    
    var tileWidth:CGFloat!
    var tilesArray:NSMutableArray = []
    var centersArray: NSMutableArray = []
    
    var mediumGreen = UIColor(red: 91.0 / 255.0, green: 229.0 / 255.0, blue: 185.0 / 255.0, alpha: 1.0)
    var deepPurple = UIColor(red: 139.0 / 255.0, green: 91.0 / 255.0, blue: 229.0 / 255.0, alpha: 1.0)
    var okayRed = UIColor(red: 247.0 / 255.0, green: 134.0 / 255.0, blue: 145.0 / 255.0, alpha: 1.0)
    
    var currentTime: Int = 0
    var gameTimer: Timer = Timer ()
   
    var compare: Bool = false
    var firstSelect: MyLabel!
    var secondSelect: MyLabel!
    
    var completed: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //createCards()
        //randomizeCards()
        loadGradientColors()
        self.resetGame(Any.self)
        timerLabel.backgroundColor = okayRed
    
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
    func createCards(){
        tileWidth = gameView.frame.size.width/4
        var xCenter:CGFloat = tileWidth/2
        var yCenter:CGFloat = tileWidth/2
        
        let tileFrame: CGRect = CGRect(x: 0, y: 0, width: tileWidth-2, height: tileWidth-2)
        
        var counter: Int = 1
        for _ in 0..<4{
            for _ in 0..<4{
                let tile: MyLabel = MyLabel(frame: tileFrame)
                
                if (counter > 8){counter = 1}
                tile.text = String (counter)
                tile.tagNumber = counter //for future use
                tile.textAlignment = NSTextAlignment.center
                tile.textColor = UIColor.white
                tile.font = UIFont.boldSystemFont(ofSize: 27)
                
                let cen:CGPoint = CGPoint(x: xCenter, y: yCenter)
                tile.isUserInteractionEnabled = true
                tile.center = cen
                tile.backgroundColor = mediumGreen
                gameView.addSubview(tile)
                
                tilesArray.add(tile)
                centersArray.add(cen)
            
                xCenter = xCenter + tileWidth
                counter += 1
            }
            yCenter = yCenter + tileWidth
            xCenter = tileWidth/2
        }
        
    }
    
    func randomizeCards(){
        //interate through tiles and assign a random center
        for tile in tilesArray
        {
            let randIndex: Int = Int(arc4random()) % centersArray.count
            let randCenter: CGPoint = centersArray[randIndex] as! CGPoint //force cast
            
            (tile as! MyLabel).center = randCenter
            centersArray.removeObject(at: randIndex) // prevents doubles
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
         // Dispose of any resources that can be recreated.
    }
    
    @IBAction func resetGame(_ sender: Any) {
        for anyView in gameView.subviews{
            anyView.removeFromSuperview()
        }
        tilesArray = []
        centersArray = []
        createCards()
        randomizeCards()
        for anyTile in tilesArray{
            (anyTile as! MyLabel).text = " "
        }
        currentTime = 0
        gameTimer.invalidate()
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self,selector: #selector(timerFunc),userInfo: nil, repeats: true)
         
    }
    
    @objc func timerFunc(){
        currentTime += 1
        
        let minutes: Int = currentTime/60
        let seconds: Int = currentTime % 60
        let timeDisplay: String = NSString(format: "%02d:%02d", minutes, seconds) as String
        timerLabel.text = timeDisplay
       
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let thisTouch: UITouch = touches.first!
        if (tilesArray.contains(thisTouch.view as Any)){
            let thisTile:MyLabel = thisTouch.view as! MyLabel
            UIView.transition(with: thisTile, duration: 0.75,
                options: UIViewAnimationOptions.transitionFlipFromRight,
                animations: {
                thisTile.text = String (thisTile.tagNumber) //show tag number when flipped
                thisTile.backgroundColor = self.deepPurple
            }, completion: { (true) in
                if (self.compare)
                {//comparing
                    self.compare = false
                    self.secondSelect = thisTile
                    self.didSelectionsMatch()
                }else{
                    //only flip back
                    self.firstSelect = thisTile
                    self.compare = true
                }
            })
        }
    }
    
    func didSelectionsMatch(){
        if (firstSelect.tagNumber == secondSelect.tagNumber){
            //match
            completed += 1
            if (completed == 8 ){
                let alert = UIAlertController(title: "Congratulations", message: "You matched all! Play Again or Quit. ", preferredStyle: UIAlertControllerStyle.alert)
                gameTimer.invalidate()
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{ action in
                    self.resetGame(Any.self)
                }))
                self.present(alert, animated: true, completion: nil)
              
            }
            firstSelect.text = "🃏"
            secondSelect.text = "🃏"
            firstSelect.backgroundColor = okayRed
            secondSelect.backgroundColor = okayRed
            firstSelect.isUserInteractionEnabled = false //cant flip back
            secondSelect.isUserInteractionEnabled = false // "
        }else{
            //not a match
            UIView.transition(with: self.view,
                              duration: 0.9,
                              options: UIViewAnimationOptions.transitionCrossDissolve,
                              animations: {
                                self.firstSelect.text = ""
                                self.secondSelect.text = " "
                                self.firstSelect.backgroundColor = self.mediumGreen
                                self.secondSelect.backgroundColor = self.mediumGreen
            },
                              completion: nil)
        }
    }

    
    func loadGradientColors() {
        view.backgroundColor = UIColor.clear
        let backgroundLayer = colors.gl
        backgroundLayer?.frame = view.frame
        view.layer.insertSublayer(backgroundLayer!, at: 0)
    }
}

class MyLabel: UILabel {
    var tagNumber: Int!
}




