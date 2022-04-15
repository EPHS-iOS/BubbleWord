//
//  Letters.swift
//  BubbleWord
//
//  Created by 90306561 on 4/14/22.
//

import Foundation
import SpriteKit
import GameplayKit

class Letters: ObservableObject{
    var letter: String
    var scrabble: Int
    var spriteNode: SKSpriteNode
    
    init (letterVal: String, scrab: Int) {
        letter = letterVal
        scrabble = scrab
        spriteNode = SKSpriteNode(imageNamed: letter)
        initialize()
    }
    func initialize() {
        
    }
}
