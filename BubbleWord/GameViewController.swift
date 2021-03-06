//
//  GameViewController.swift
//  BubbleWord
//
//  Created by 90306561 on 3/16/22.
//
import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
            
            // Get the SKScene from the loaded GKScene
                
                // Present the scene
                if let view = self.view as! SKView? {
                    // Load the SKScene from 'GameScene.sks'
                    let scene = MainMenuScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
                        // Set the scale mode to scale to fit the window
                    scene.scaleMode = .fill
                        
                        // Present the scene
                        view.presentScene(scene)
                    
                    
                    //view.ignoresSiblingOrder = true
                    
                    //view.showsFPS = true
                    //view.showsNodeCount = true
                }
            
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
