//
//  HalfCircleButton.swift
//  FurysApp
//
//  Created by Dion MacIntyre on 30/03/2017.
//  Copyright © 2017 Dion MacIntyre. All rights reserved.
//

import UIKit
@IBDesignable
class HalfCircleButton: UIButton {

    enum side{
        case right
        case left
    }
    @IBInspectable
    var scale: CGFloat = 0.9
    @IBInspectable
    var rightSide = true
    
    private var orientation: side {
        if(rightSide){
            return .right
        } else{
            return .left
        }
    }
    
    private var circleRadius: CGFloat{
        return min(bounds.size.width, bounds.size.height) / 2 * scale
    }
    private var circleCentre: CGPoint{
        if(orientation == .left){
            return CGPoint(x: bounds.maxX, y: bounds.midY)
        } else{
            return CGPoint(x: bounds.minX, y: bounds.midY)
        }
    }
    
    private func pathForHalfCentredAtPoint(midPoint: CGPoint, withRadius radius: CGFloat, half: side) -> UIBezierPath{
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: midPoint.x, y: midPoint.y + radius))
        path.addLine(to: CGPoint(x: midPoint.x, y: midPoint.y - radius))
        if(half == .right){
            path.addQuadCurve(to: CGPoint(x: midPoint.x + radius, y: midPoint.y), controlPoint: CGPoint(x: midPoint.x + radius, y: midPoint.y - radius))
            path.addQuadCurve(to: CGPoint(x: midPoint.x, y: midPoint.y + radius), controlPoint: CGPoint(x: midPoint.x + radius, y: midPoint.y + radius))
        } else{
            path.addQuadCurve(to: CGPoint(x: midPoint.x - radius, y: midPoint.y), controlPoint: CGPoint(x: midPoint.x - radius, y: midPoint.y - radius))
            path.addQuadCurve(to: CGPoint(x: midPoint.x, y: midPoint.y + radius), controlPoint: CGPoint(x: midPoint.x - radius, y: midPoint.y + radius))
        }
        
        path.lineWidth = 2.0
        return path
    }

    
    
    override func draw(_ rect: CGRect) {
        UIColor.black.set()
        pathForHalfCentredAtPoint(midPoint: circleCentre, withRadius: circleRadius, half: orientation).stroke()
    }
}
