//
//  BirdNode.swift
//  Boid
//
//  Created by Tatsuya Tobioka on 9/14/14.
//  Copyright (c) 2014 tnantoka. All rights reserved.
//

import SpriteKit

class BirdNode: SKNode {
    let radius = 10.0
    let base = -50.0

    let maxSpeed: CGFloat = 4.0
    
    var velocity = CGPoint(x: 0.0, y: 0.0)

    let rules: [Rule]!
    
    override init() {
        super.init()
        
        self.rules = [
            CohesionRule(weight: 1.0),
            SeparationRule(weight: 0.8),
            AlignmentRule(weight: 0.1)
        ]
        
        //self.addShapeNode()
        self.addFireNode()
    }
    
    func addShapeNode() {
        let path = CGPathCreateMutable()
        let degrees = [0.0, 130.0, 260.0]
        for degree in degrees {
            let point = Utility.rotatedPoint(degree: degree, radius: self.radius, base: self.base)
            if degree == 0.0 {
                CGPathMoveToPoint(path, nil, point.x, point.y)
            } else {
                CGPathAddLineToPoint(path, nil, point.x, point.y)
            }
        }
        
        let shapeNode = SKShapeNode(path: path)
        shapeNode.fillColor = SKColor.whiteColor()
        
        self.addChild(shapeNode)
    }
    
    func addFireNode() {
        let fireNode = NSKeyedUnarchiver.unarchiveObjectWithFile(NSBundle.mainBundle().pathForResource("fire", ofType: "sks")!) as SKEmitterNode
        fireNode.particleScale = 0.1
        fireNode.xScale = 0.7
        fireNode.yScale = 0.9
        
        fireNode.particleLifetime = 0.3
        fireNode.emissionAngle = -CGFloat(Utility.degreeToRadian(90.0))
        fireNode.emissionAngleRange = 0.0
        fireNode.particlePositionRange = CGVector(dx: 0.0, dy: 0.1)

        fireNode.particleColor = SKColor.orangeColor()
        
        self.addChild(fireNode)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func update(#birdNodes: [BirdNode], frame: CGRect) {
        for rule in self.rules {
            rule.evaluate(targetNode: self, birdNodes: birdNodes)
        }
        self.move(frame)
        self.rotate()
    }

    private func move(frame: CGRect) {
        self.velocity.x += rules.reduce(0.0, combine: { sum, r in sum + r.weighted.x })
        self.velocity.y += rules.reduce(0.0, combine: { sum, r in sum + r.weighted.y })

        let vector = sqrt(self.velocity.x * self.velocity.x + self.velocity.y * self.velocity.y)
        if (vector > self.maxSpeed) {
            self.velocity.x = (self.velocity.x / vector) * self.maxSpeed
            self.velocity.y = (self.velocity.y / vector) * self.maxSpeed
        }
        
        self.position.x += velocity.x
        self.position.y += velocity.y
        
        if (self.position.x - CGFloat(self.radius) <= 0) {
            self.position.x = CGFloat(self.radius)
            self.velocity.x *= -1
        }
        if (self.position.x + CGFloat(self.radius) >= CGRectGetWidth(frame)) {
            self.position.x = CGRectGetWidth(frame) - CGFloat(self.radius)
            self.velocity.x *= -1
        }

        if (self.position.y - CGFloat(self.radius) <= 0) {
            self.position.y = CGFloat(self.radius)
            self.velocity.y *= -1
        }
        if (self.position.y + CGFloat(self.radius) >= CGRectGetHeight(frame)) {
            self.position.y = CGRectGetHeight(frame) - CGFloat(self.radius)
            self.velocity.y *= -1
        }
    }
    
    private func rotate() {
        var radian = -atan2(Double(velocity.x), Double(velocity.y))
        self.zRotation = CGFloat(radian)
    }
}
