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
    
    var tileWidth:CGFloat!
    var tilesArray:NSMutableArray = []
    var centersArray: NSMutableArray = []
    
    var currentTime: Int = 0
    var gameTimer: Timer = Timer ()
   
    var compare: Bool = false
    var firstSelect: MyLabel!
    var secondSelect: MyLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //createCards()
        //randomizeCards()
        self.resetGame(Any.self)
        
        
    }
    
    func createCards(){
        tileWidth = gameView.frame.size.width/4
        var xCenter:CGFloat = tileWidth/2
        var yCenter:CGFloat = tileWidth/2
        
        var tileFrame: CGRect = CGRect(x: 0, y: 0, width: tileWidth-2, height: tileWidth-2)
        
        var counter: Int = 1
        for _ in 0..<4{
            for _ in 0..<4{
                let tile: MyLabel = MyLabel(frame: tileFrame)
                
                if (counter > 8){counter = 1}
                tile.text = String (counter)
                tile.tagNumber = counter //for future use
                tile.textAlignment = NSTextAlignment.center
                tile.font = UIFont.boldSystemFont(ofSize: 27)
                
                let cen:CGPoint = CGPoint(x: xCenter, y: yCenter)
                tile.isUserInteractionEnabled = true
                tile.center = cen
                tile.backgroundColor = UIColor.blue
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
                thisTile.backgroundColor = UIColor.cyan
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
            firstSelect.text = "😻"
            secondSelect.text = "😻"
            firstSelect.backgroundColor = UIColor.green
            secondSelect.backgroundColor = UIColor.green
        }else{
            //not a match
            UIView.transition(with: self.view,
                              duration: 0.9,
                              options: UIViewAnimationOptions.transitionCrossDissolve,
                              animations: {
                                self.firstSelect.text = ""
                                self.secondSelect.text = " "
                                self.firstSelect.backgroundColor = UIColor.blue
                                self.secondSelect.backgroundColor = UIColor.blue
            },
                              completion: nil)
        }
    }

}

class MyLabel: UILabel {
    var tagNumber: Int!
}


