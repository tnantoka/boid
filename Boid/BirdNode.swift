//
//  BirdNode.swift
//  Boid
//
//  Created by Tatsuya Tobioka on 9/14/14.
//  Copyright (c) 2014 tnantoka. All rights reserved.
//

import SpriteKit

class BirdNode: SKShapeNode {
    let radius = 10.0
    let base = -50.0

    let centerPullFactor = CGFloat(300.0)
    let distThreshold = 30.0
    let matchFactor = CGFloat(2.0)
    let maxSpeed = CGFloat(4.0)
    
    var velocity = CGPoint(x: 0.0, y: 0.0)

    var v1 = CGPoint(x: 0.0, y: 0.0)
    var v2 = CGPoint(x: 0.0, y: 0.0)
    var v3 = CGPoint(x: 0.0, y: 0.0)
    
    let w1 = CGFloat(1.0)
    let w2 = CGFloat(0.8)
    let w3 = CGFloat(0.1)
    
    override init() {
        super.init()
        
        let path = UIBezierPath()
        path.moveToPoint(self.pointWithDegree(0.0))
        //let degrees = [120.0, 240.0]
        let degrees = [140.0, 280.0]
        for degree in degrees {
            path.addLineToPoint(self.pointWithDegree(degree))
        }
        path.closePath()
        
        self.path = path.CGPath
        self.fillColor = UIColor.redColor()
        
        //self.zRotation = CGFloat(90.0 * M_PI / 180.0)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func degreeToRadian(degree: Double) -> Double {
        return degree * M_PI / 180.0
    }
    
    func update(#birdNodes: [BirdNode], frame: CGRect) {
        self.clear()
        self.rule1(birdNodes)
        self.rule2(birdNodes)
        self.rule3(birdNodes)
        self.move(frame)
        self.rotate()
    }

    private func clear() {
        self.v1 = CGPoint(x: 0.0, y: 0.0)
        self.v2 = CGPoint(x: 0.0, y: 0.0)
        self.v3 = CGPoint(x: 0.0, y: 0.0)
    }
    
    private func move(frame: CGRect) {
        self.velocity.x += self.v1.x * self.w1 + self.v2.x * self.w2 + self.v3.x * self.w3
        self.velocity.y += self.v1.y * self.w1 + self.v2.y * self.w2 + self.v3.y * self.w3

        let vVector = sqrt(velocity.x * velocity.x + velocity.y * velocity.y)
        if (vVector > self.maxSpeed) {
            velocity.x = (velocity.x / vVector) * self.maxSpeed
            velocity.y = (velocity.y / vVector) * self.maxSpeed
        }
        
        self.position.x += velocity.x
        self.position.y += velocity.y
        
        if (self.position.x - CGFloat(self.radius) <= 0) {
            self.position.x = CGFloat(self.radius)
            velocity.x *= -1
        }
        if (self.position.x + CGFloat(self.radius) >= CGRectGetWidth(frame)) {
            self.position.x = CGRectGetWidth(frame) - CGFloat(self.radius)
            velocity.x *= -1
        }

        if (self.position.y - CGFloat(self.radius) <= 0) {
            self.position.y = CGFloat(self.radius)
            velocity.y *= -1
        }
        if (self.position.y + CGFloat(self.radius) >= CGRectGetHeight(frame)) {
            self.position.y = CGRectGetHeight(frame) - CGFloat(self.radius)
            velocity.y *= -1
        }
    }
    
    private func rotate() {
        var radian = -atan2(Double(velocity.x), Double(velocity.y))
        self.zRotation = CGFloat(radian)
    }

    private func rule1(birdNodes: [BirdNode]) {
        for birdNode in birdNodes {
            if birdNode != self {
                self.v1.x += birdNode.position.x
                self.v1.y += birdNode.position.y
            }
        }
        
        self.v1.x /= CGFloat(birdNodes.count - 1)
        self.v1.y /= CGFloat(birdNodes.count - 1)
        
        self.v1.x = (self.v1.x - self.position.x) / self.centerPullFactor
        self.v1.y = (self.v1.y - self.position.y) / self.centerPullFactor
    }

    private func rule2(birdNodes: [BirdNode]) {
        for birdNode in birdNodes {
            if birdNode != self {
                if self.distanceWith(birdNode) < self.distThreshold {
                    self.v2.x -= birdNode.position.x - self.position.x
                    self.v2.y -= birdNode.position.y - self.position.y
                }
            }
        }
    }

    private func rule3(birdNodes: [BirdNode]) {
        for birdNode in birdNodes {
            if birdNode != self {
                self.v3.x += birdNode.velocity.x
                self.v3.y += birdNode.velocity.y
            }
        }
        
        self.v3.x /= CGFloat(birdNodes.count - 1)
        self.v3.y /= CGFloat(birdNodes.count - 1)

        self.v3.x = (self.v3.x - self.velocity.x) / self.matchFactor
        self.v3.y = (self.v3.y - self.velocity.y) / self.matchFactor
    }

    private func pointWithDegree(degree: Double) -> CGPoint {
        let radian = self.degreeToRadian(degree + self.base)
        let x = self.radius * cos(radian)
        let y = self.radius * sin(radian)
        return CGPoint(x: x, y: y)
    }
    
    private func distanceWith(birdNode: BirdNode) -> Double {
        let x = Double(self.position.x - birdNode.position.x)
        let y = Double(self.position.y - birdNode.position.y)
        return sqrt(x * x  + y * y)
    }
}
