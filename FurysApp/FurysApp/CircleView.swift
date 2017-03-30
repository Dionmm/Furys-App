//
//  CircleView.swift
//  FurysApp
//
//  Created by Dion MacIntyre on 28/03/2017.
//  Copyright © 2017 Dion MacIntyre. All rights reserved.
//

import UIKit

@IBDesignable
class CircleView: UIView {

    var scale: CGFloat = 0.9
    private var rightHalf = UIBezierPath()
    private var leftHalf = UIBezierPath()
    private var circleRadius: CGFloat{
        return min(bounds.size.width, bounds.size.height) / 2 * scale
    }
    private var circleCentre: CGPoint{
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    private enum side{
        case right
        case left
    }
    private func pathForHalfCentredAtPoint(midPoint: CGPoint, withRadius radius: CGFloat, half: side) -> UIBezierPath{
        /*let path = UIBezierPath(
            arcCenter: midPoint,
            radius: radius,
            startAngle: 0.0,
            endAngle: CGFloat(2*Double.pi),
            clockwise: false)*/
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: midPoint.x, y: midPoint.y + radius))
        path.addLine(to: CGPoint(x: midPoint.x, y: midPoint.y - radius))
        if(half == side.right){
            path.addQuadCurve(to: CGPoint(x: midPoint.x + radius, y: midPoint.y), controlPoint: CGPoint(x: midPoint.x + radius, y: midPoint.y - radius))
            path.addQuadCurve(to: CGPoint(x: midPoint.x, y: midPoint.y + radius), controlPoint: CGPoint(x: midPoint.x + radius, y: midPoint.y + radius))
        } else{
            path.addQuadCurve(to: CGPoint(x: midPoint.x - radius, y: midPoint.y), controlPoint: CGPoint(x: midPoint.x - radius, y: midPoint.y - radius))
            path.addQuadCurve(to: CGPoint(x: midPoint.x, y: midPoint.y + radius), controlPoint: CGPoint(x: midPoint.x - radius, y: midPoint.y + radius))
        }
        
        path.lineWidth = 2.0
        return path
    }
    //Detect the touches within the boundary of the drawn paths
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self.superview)
            if(rightHalf.contains(location)){
                print("Tap right")
            } else if(leftHalf.contains(location)){
                print("Tap left")
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.black.set()
        rightHalf = pathForHalfCentredAtPoint(midPoint: circleCentre, withRadius: circleRadius, half: side.right)
        rightHalf.stroke()
        leftHalf = pathForHalfCentredAtPoint(midPoint: circleCentre, withRadius: circleRadius, half: side.left)
        leftHalf.stroke()
    }

}
