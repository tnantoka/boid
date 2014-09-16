//
//  BoidScene.swift
//  Boid
//
//  Created by Tatsuya Tobioka on 9/14/14.
//  Copyright (c) 2014 tnantoka. All rights reserved.
//

import SpriteKit

class BoidScene: SKScene {
 
    let numberOfBirds = 10
    
    var birdNodes = [BirdNode]()
    var contentCreated = false
    
    override func didMoveToView(view: SKView) {
        self.scaleMode = .AspectFit
        
        self.createSceneContents()
    }
    
    func createSceneContents() {
        if self.contentCreated {
            return
        }

        let degree: Double = 360.0 / Double(numberOfBirds)
        let radius = 120.0
        for i in 0..<numberOfBirds {
            let birdNode = BirdNode()
            let degree = degree * Double(i)
            let radian = Utility.degreeToRadian(degree)
            let x = Double(CGRectGetMidX(self.frame)) + cos(radian) * radius
            let y = Double(CGRectGetMidY(self.frame)) + sin(radian) * radius
            birdNode.position = CGPoint(x: x, y: y)
            
            self.addChild(birdNode)
            self.birdNodes.append(birdNode)
        }
        
        self.contentCreated = true
    }
    
    override func update(currentTime: NSTimeInterval) {
        for birdNode in birdNodes {
            birdNode.update(birdNodes: birdNodes, frame: self.frame)
        }
    }
    
//    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
//        self.createSceneContents()
//    }
}
