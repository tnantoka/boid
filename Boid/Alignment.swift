//
//  Alignment.swift
//  Boid
//
//  Created by Tatsuya Tobioka on 9/15/14.
//  Copyright (c) 2014 tnantoka. All rights reserved.
//

import UIKit

class Alignment: Rule {
    let factor: CGFloat = 2.0
    
    override func evaluate(#targetNode: BirdNode, birdNodes: [BirdNode]) {
        super.evaluate(targetNode: targetNode, birdNodes: birdNodes)

        for birdNode in birdNodes {
            if birdNode != targetNode {
                velocity.x += birdNode.velocity.x
                velocity.y += birdNode.velocity.y
            }
        }
        
        velocity.x /= CGFloat(birdNodes.count - 1)
        velocity.y /= CGFloat(birdNodes.count - 1)
        
        velocity.x = (velocity.x - targetNode.velocity.x) / self.factor
        velocity.y = (velocity.y - targetNode.velocity.y) / self.factor
    }
}