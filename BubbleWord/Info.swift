//
//  Info.swift
//  BubbleWord
//
//  Created by 90306561 on 4/19/22.
//

import Foundation
import UIKit
import SpriteKit
import GameplayKit

let backNode = SKSpriteNode(imageNamed: "Back")


class Info: SKScene{
    
    override func didMove(to view: SKView) {
        self.backgroundColor = UIColor.systemBlue
        let title = SKLabelNode(text: "Directions")
        title.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.90)
        title.fontName = "Microsoft Sans Serif"
        title.fontSize = 40
        addChild(title)
        
        let directions = SKLabelNode(text: "The goal of the game is to get as many points as possible. To get points, aim the shooter at a letter and spell out a word. When done, click the check mark and if it is a word, you'll get points for your word. Otherwise, you can click the big X and it'll replace the letters, but be careful, you lose points if you use it! If there's a letter you just can't use, click the X and enter cancel mode, where you can get rid of letters (this will lower your score). Have fun!")
        directions.preferredMaxLayoutWidth = width - 10
        directions.numberOfLines = 14
        directions.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.30)
        directions.fontName = "Microsoft Sans Serif"
        directions.fontSize = 24
        addChild(directions)
        
        backNode.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.10)
        addChild(backNode)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
        let touchLocation = touch.location(in: self)
        let touchedWhere = nodes(at: touchLocation)
        if !touchedWhere.isEmpty {
            for node in touchedWhere {
                if let sprite = node as? SKSpriteNode {
                    if sprite == backNode {
                        let sceneToMoveTo = MainMenuScene(size: self.size)
                        sceneToMoveTo.scaleMode = .resizeFill
                        let transition1 = SKTransition.fade(withDuration: 0.6)
                        self.view!.presentScene(sceneToMoveTo, transition: transition1)
                        }
                    }
                }
            }
        }
    }
}
