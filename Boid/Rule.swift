//
//  Rule.swift
//  Boid
//
//  Created by Tatsuya Tobioka on 9/15/14.
//  Copyright (c) 2014 tnantoka. All rights reserved.
//

import UIKit

class Rule: NSObject {
    var velocity: CGPoint!
    var weight: CGFloat

    var weighted: CGPoint {
        return CGPoint(x: self.velocity.x * self.weight, y: self.velocity.y * self.weight)
    }

    init(weight: CGFloat) {
        self.weight = weight
        super.init()
        self.clear()
    }
    
    func clear() {
        self.velocity = CGPoint(x: 0.0, y: 0.0)
    }
    
    func evaluate(#targetNode: BirdNode, birdNodes: [BirdNode]) {
        self.clear()
    }    
}