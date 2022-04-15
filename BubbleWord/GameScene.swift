//
//  GameScene.swift
//  jake-evan-erik
//
//  Created by 90306561 on 3/16/22.

import SpriteKit
import GameplayKit

var width = UIScreen.main.bounds.width
var height = UIScreen.main.bounds.height
let Size = width/8
let gap = 2 * Size / 5
var localWidth = width / 2 - Size / 2
//look into if can detect notch
var localHeight = height / 2 - Size / 2 - 50


let allWords: [[String]] = [wordsA, wordsB, wordsC, wordsD, wordsE, wordsF, wordsG, wordsH, wordsI, wordsJ, wordsK, wordsL, wordsM, wordsN, wordsO, wordsP, wordsQ, wordsR, wordsS, wordsT, wordsU, vwxyzWords]

var cancelMode = false

var word : SKLabelNode!
var score : SKLabelNode!
var scoreInt = 0
var val = 0

let letters: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

let weighted: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 6, 6, 7, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8, 9, 10, 11, 11, 11, 11, 12, 12, 13, 13, 13, 13, 13, 13, 13, 14, 14, 14, 14, 14, 14, 14, 14, 15, 15, 16, 17, 17, 17, 17, 17, 18, 18, 18, 18, 18, 18, 19, 19, 19, 19, 19, 19, 19, 19, 19, 20, 20, 20, 21, 22, 22, 23, 24, 24, 25]

let scrabble: [Int] = [1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10]

var nodes: [Letters] = []
var XWords: [Letters] = []

var check = SKSpriteNode(imageNamed: "check")
var cancel = SKSpriteNode(imageNamed: "Xulu")

var Shooter = SKSpriteNode(imageNamed: "Shooter")
var BS = SKSpriteNode(imageNamed: "BS")
var Ball = SKSpriteNode(imageNamed: "Ball")

var OG : CGPoint?
var ZRot = false
var ballCount = 0

var dx : CGFloat?

let aCount = wordsA.count
let bCount = wordsB.count
let cCount = wordsC.count
let dCount = wordsD.count
let eCount = wordsE.count
let fCount = wordsF.count
let gCount = wordsG.count
let hCount = wordsH.count
let iCount = wordsI.count
let jCount = wordsJ.count
let kCount = wordsK.count
let lCount = wordsL.count
let mCount = wordsM.count
let nCount = wordsN.count
let oCount = wordsO.count
let pCount = wordsP.count
let qCount = wordsQ.count
let rCount = wordsR.count
let sCount = wordsS.count
let tCount = wordsT.count
let uCount = wordsU.count
let vwxyzCount = vwxyzWords.count
let count: [Int] = [aCount, bCount, cCount, dCount, eCount, fCount, gCount, hCount, iCount, jCount, kCount, lCount, mCount, nCount, oCount, pCount, qCount, rCount, sCount, tCount, uCount, vwxyzCount, vwxyzCount, vwxyzCount, vwxyzCount, vwxyzCount]

class GameScene: SKScene, SKPhysicsContactDelegate {
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    let allNewWords: [[String]] = organize(data: readFile(inputFile: "words.txt"))
    
    override func didMove(to view: SKView) {
        
        
        physicsWorld.contactDelegate = self
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        initialize()
        
    }
    
    func findList(length: Int) -> [String]{
        var index = 0
        var isFound = false
        while(!isFound){
           let tempWords = allWords[index]
            if(length == tempWords.count){
                isFound = true
                return allWords[index]
            }
            index += 1
        }
    }
    
    
    // Touches Functions
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
        let touchLocation = touch.location(in: self)
        let touchedWhere = nodes(at: touchLocation)
            ZRot = false
            OG = touchLocation
            if !touchedWhere.isEmpty {
                    for node in touchedWhere {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == check {
                                if word.text == "ERIK" {
                                    scoreInt += 100
                                    score.text = "Score: " + String(scoreInt)
                                    word.text = ""
                                    XWords.removeAll()
                                }
                                else {
                                    if word.text != "" {
                                        let firstLetter = word.text!.prefix(1)
                                        var position = -1
                                        var quickboolean = false
                                        while (!quickboolean) {
                                            position += 1
                                            if firstLetter == letters[position] {
                                                quickboolean = true
                                            }
                                        }
                                        
                                        
                                        var tempArray: [String]
                                        tempArray = findList(length: count[position])
                                        for n in 0...(tempArray.count - 1) {
                                            if tempArray[n].localizedUppercase == word.text! {
                                                scoreInt += scrabVal()
                                                score.text = "Score: " + String(scoreInt)
                                                XWords.removeAll()
                                                ballCount += 1
                                                if ballCount % 4 == 0 && ballCount != 0{
                                                    addSquares()
                                                }
                                                return
                                            }
                                        }
                                    }
                                }
                            }
                            if sprite == cancel {
                                if cancelMode {
                                    cancelMode = false
                                }
                                else if word.text != "" {
                                    scoreInt -= scrabVal()
                                    score.text = "Score: " + String(scoreInt)
                                    for n in 0...(XWords.count - 1){
                                        BubbleWord.nodes.append(XWords[n])
                                        addChild(XWords[n].spriteNode)
                                    }
                                    word.text = ""
                                    XWords.removeAll()
                                }
                                else{cancelMode = true}
                            }
                        }
                    }
                }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: self)
            shooter(touchLocation: touchLocation)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: self)
            if ZRot {
                let x1 = touchLocation.x
                let y1 = touchLocation.y + 321
                let theta = -1 * atan(x1/y1)
                Shooter.removeFromParent()
                Ball.removeFromParent()
                BS.removeFromParent()
                BS.zRotation = Shooter.zRotation
                Ball.position = CGPoint(x: theta, y: -321)
                Ball.zRotation = theta
                addChild(Ball)
                addChild(BS)
                dx = theta * 360 * -1
                Ball.physicsBody?.velocity = CGVector(dx: theta * 360 * -1, dy: 350)
            }
        }
    }
    
    
    // Functions for Touch
    
    
    func shooter(touchLocation: CGPoint){
        let x1 = touchLocation.x
        let y1 = touchLocation.y + 321
        let theta = -1 * atan(x1 / y1)
        if Shooter.zRotation != theta {
            ZRot = true
        }
        Shooter.zRotation = theta
    }
   
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "Ball" {
            collision(between: contact.bodyA.node!, object: contact.bodyB.node!)
        }
        else if contact.bodyB.node?.name == "Ball" {
            collision(between: contact.bodyB.node!, object: contact.bodyA.node!)
        }
    }
    
    func scrabVal() -> Int {
        var tempWord = word.text!
        var scrabScore = 0
        while tempWord.count > 0 {
            for scrabblevalues in 0...25 {
                if tempWord.prefix(1) == letters[scrabblevalues ] {
                    scrabScore += scrabble[scrabblevalues]
                    tempWord = String(tempWord.suffix(tempWord.count - 1))
                }
            }
        }
        word.text = ""
        return scrabScore
    }
    
    func letterNum(object: SKNode) -> Int {
        if BubbleWord.nodes.count != 0 {
            for n in 0...(BubbleWord.nodes.count - 1) {
                if object == BubbleWord.nodes[n].spriteNode {
                    return n
                }
            }
        }
        return -1
    }
    
    func collision(between Ball: SKNode, object: SKNode) {
        let n = letterNum(object: object)
            if n != -1 {
                Ball.removeFromParent()
                BS.removeFromParent()
                Shooter.removeFromParent()
                addChild(Shooter)
                Shooter.zRotation = 0
                if cancelMode {
                    scoreInt -= BubbleWord.nodes[n].scrabble
                    score.text = "Score: " + String(scoreInt)
                    object.removeFromParent()
                    BubbleWord.nodes.remove(at: n)
                            }
                            else {
                                XWords.append(BubbleWord.nodes[n])
                                object.removeFromParent()
                                word.text = word.text! + BubbleWord.nodes[n].letter
                                BubbleWord.nodes.remove(at: n)
                            }
            }
        else {
            if Ball.position.y >= height / 2 - 22 || Ball.position.y <= ((height / 2) * -1) - 22{
                Ball.physicsBody?.velocity = CGVector(dx: dx!, dy: -350)
                scoreInt += 1
                score.text = "Score: " + String(scoreInt)
            }
            else {
                Ball.physicsBody?.velocity = CGVector(dx: dx! * -1, dy: 350)
                scoreInt += 1
                score.text = "Score: " + String(scoreInt)
            }
        }
    }
    
    func addSquares() {
        var n = BubbleWord.nodes.count - 1
        while n >= 0 {
            if BubbleWord.nodes[n].spriteNode.position.y > -198 {
                BubbleWord.nodes[n].spriteNode.position.y -= CGFloat(((gap + Size) * 2))
                n -= 1
            }
            else {
                //end game
            }
        }
        for _ in 0...11 {
            let randomInt = Int.random(in: 0...100)
            let random = weighted[randomInt]
            let tempLetterObject = Letters(letterVal: letters[random], scrab: scrabble[random])
            localWidth = localWidth - gap - Size
            if n % 6 == 0 {
                localWidth = width / 2 - Size / 2
                localHeight -= (gap + Size)
            }

            BubbleWord.nodes.append(tempLetterObject)
            addChild(tempLetterObject.spriteNode)
        }
    }
    
    func initialize(){
        check.position = CGPoint(x: 137.5, y: -337.847)
        check.zPosition = 1
        addChild(check)
        cancel.position = CGPoint(x: -137.5, y: -337.847)
        cancel.zPosition = 1
        addChild(cancel)
        Shooter.size = CGSize(width: 78, height: 108)
        Shooter.position = CGPoint(x: 0, y: -321)
        addChild(Shooter)
        BS.size = CGSize(width: 78, height: 108)
        BS.position = CGPoint(x: 0, y: -321)
        BS.zPosition = 1
        Ball.size = CGSize(width: 35, height: 35)
        Ball.physicsBody = SKPhysicsBody(circleOfRadius: 17.5)
        Ball.physicsBody?.contactTestBitMask = Ball.physicsBody?.collisionBitMask ?? 0
        Ball.physicsBody?.affectedByGravity = false
        Ball.zPosition = 0
        Ball.physicsBody?.mass = 0.0997
        Ball.name = "Ball"
        word = SKLabelNode(text: "")
        word.fontName = "Microsoft Sans Serif"
        word.fontSize = 18.0
        word.position = CGPoint(x: localWidth - 10, y: localHeight + 30)
        addChild(word)
        score = SKLabelNode(text: "Score: 0")
        score.fontName = "Microsoft Sans Serif"
        score.fontSize = 18.0
        score.position = CGPoint(x: -1 * (localWidth - 10), y: localHeight + 30)
        addChild(score)
        var n = 0
            while n < 30 {
                let randomInt = Int.random(in: 0...100)
                let random = weighted[randomInt]
                let tempLetterObject = Letters(letterVal: letters[random], scrab: scrabble[random])
                n+=1
                tempLetterObject.spriteNode.size = CGSize(width: Size, height: Size)
                tempLetterObject.spriteNode.position = CGPoint(x: localWidth, y: localHeight)
                tempLetterObject.spriteNode.physicsBody?.isDynamic = false
                tempLetterObject.spriteNode.physicsBody = SKPhysicsBody(rectangleOf: tempLetterObject.spriteNode.size)
                tempLetterObject.spriteNode.physicsBody?.contactTestBitMask = tempLetterObject.spriteNode.physicsBody?.collisionBitMask ?? 0
                tempLetterObject.spriteNode.physicsBody?.affectedByGravity = false
                tempLetterObject.spriteNode.zPosition = 0
                tempLetterObject.spriteNode.name = tempLetterObject.letter
                BubbleWord.nodes.append(tempLetterObject)
                addChild(tempLetterObject.spriteNode)
                localWidth = localWidth - gap - Size
                if n % 6 == 0 {
                    localWidth = width / 2 - Size / 2
                    localHeight -= (gap + Size)
                }
            }
    }
}

//530
