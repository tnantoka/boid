//
//  BoidScene.swift
//  Boid
//
//  Created by Tatsuya Tobioka on 9/14/14.
//  Copyright (c) 2014 tnantoka. All rights reserved.
//

import SpriteKit

class BoidScene: SKScene {
 
    var contentCreated = false
    
    override func didMoveToView(view: SKView) {
        if !self.contentCreated {
            self.scaleMode = .AspectFit
            self.backgroundColor = UIColor.whiteColor()
            
            self.contentCreated = true
        }
    }
}
