//
//  MainMenuScene.swift
//  BubbleWord
//
//  Created by 90306561 on 4/18/22.
//
import Foundation
import UIKit
import SpriteKit
import GameplayKit

let directions = SKSpriteNode(imageNamed: "Directions")
let startGame = SKLabelNode()

class MainMenuScene: SKScene{
    override func didMove(to view: SKView) {
//        let background = SKSpriteNode(imageNamed: "background")
//        background.size = self.size
//        background.zPosition = 0
//        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
//        self.addChild(background)
        
        let title1 = SKLabelNode()
        title1.fontSize = 150
        title1.fontColor = SKColor.white
        title1.text = "Bubble Word"
        title1.zPosition = 1
        title1.setScale(0.5)
        title1.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.65)
        self.addChild(title1)
        
        
        startGame.fontSize = 75
        startGame.fontColor = SKColor.white
        startGame.text = "Start Game"
        startGame.zPosition = 1
        startGame.name = "Start Button"
        startGame.setScale(0.5)
        startGame.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.4)
        self.addChild(startGame)
        
        directions.position = CGPoint(x: size.width/2, y: size.height * 0.1)
        addChild(directions)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
            if let touch = touches.first {
            let touchLocation = touch.location(in: self)
            let touchedWhere = nodes(at: touchLocation)
            if !touchedWhere.isEmpty {
                for node in touchedWhere {
                    if let sprite = node as? SKSpriteNode {
                        if sprite == directions {
                            let sceneToMoveTo = Info(size: self.size)
                            sceneToMoveTo.scaleMode = .resizeFill
                            let transition1 = SKTransition.fade(withDuration: 0.6)
                            self.view!.presentScene(sceneToMoveTo, transition: transition1)
                            }
                        
                        }
                    else if let sprite = node as? SKLabelNode {
                        if sprite == startGame {
                            let scene = GKScene(fileNamed: "GameScene")
                            let sceneToMoveTo = scene!.rootNode as! GameScene
                            sceneToMoveTo.scaleMode = .fill
                            //let myTransition = SKTransition.fade(withDuration: 0.5)
                            self.view!.presentScene(sceneToMoveTo)
                            //transition: myTransition
                        }
                    }
                    }
                }
            }
        
        
        
    }
}
