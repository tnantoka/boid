//
//  Separation.swift
//  Boid
//
//  Created by Tatsuya Tobioka on 9/15/14.
//  Copyright (c) 2014 tnantoka. All rights reserved.
//

import UIKit

class Separation: Rule {
    let threshold = 30.0
    
    override func evaluate(#targetNode: BirdNode, birdNodes: [BirdNode]) {
        super.evaluate(targetNode: targetNode, birdNodes: birdNodes)

        for birdNode in birdNodes {
            if birdNode != targetNode {
                if Utility.distanceBetween(targetNode.position, birdNode.position) < self.threshold {
                    velocity.x -= birdNode.position.x - targetNode.position.x
                    velocity.y -= birdNode.position.y - targetNode.position.y
                }
            }
        }
    }
}
