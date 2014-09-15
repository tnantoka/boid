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
        if !self.contentCreated {
            self.createSceneContents()
            self.contentCreated = true
        }
    }
    
    func createSceneContents() {
        self.scaleMode = .AspectFit
        //self.backgroundColor = UIColor.whiteColor()
        
        let degree: Double = 360.0 / Double(numberOfBirds)
        let radius = 100.0
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
    }
    
    override func update(currentTime: NSTimeInterval) {
        for birdNode in birdNodes {
            birdNode.update(birdNodes: birdNodes, frame: self.frame)
        }
    }
}
