//
//  SeparationRule.swift
//  Boid
//
//  Created by Tatsuya Tobioka on 9/15/14.
//  Copyright (c) 2014 tnantoka. All rights reserved.
//

import UIKit

class SeparationRule: Rule {
    let threshold = 30.0
    
    override func evaluate(targetNode targetNode: BirdNode, birdNodes: [BirdNode]) {
        super.evaluate(targetNode: targetNode, birdNodes: birdNodes)

        for birdNode in birdNodes {
            if birdNode != targetNode {
                if Utility.distanceBetween(targetNode.position, birdNode.position) < self.threshold {
                    self.velocity.x -= birdNode.position.x - targetNode.position.x
                    self.velocity.y -= birdNode.position.y - targetNode.position.y
                }
            }
        }
    }
}
