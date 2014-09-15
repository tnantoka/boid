//
//  Utility.swift
//  Boid
//
//  Created by Tatsuya Tobioka on 9/15/14.
//  Copyright (c) 2014 tnantoka. All rights reserved.
//

import UIKit

class Utility: NSObject {
    class func degreeToRadian(degree: Double) -> Double {
        return degree * M_PI / 180.0
    }
    
    class func distanceBetween(pointA: CGPoint, _ pointB: CGPoint) -> Double {
        let x = Double(pointA.x - pointB.x)
        let y = Double(pointA.y - pointB.y)
        return sqrt(x * x  + y * y)
    }

    class func rotatedPoint(#degree: Double, radius: Double, base: Double = 0.0) -> CGPoint {
        let radian = Utility.degreeToRadian(degree + base)
        let x = radius * cos(radian)
        let y = radius * sin(radian)
        return CGPoint(x: x, y: y)
    }

}
