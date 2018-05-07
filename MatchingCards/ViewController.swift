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
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCards()
        randomizeCards()
        
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
    }
}

class MyLabel: UILabel {
    var tagNumber: Int!
}


