//
//  SODAxisLineView.swift
//  Sodalite
//
//  Created by S-Shimotori on 5/17/15.
//  Copyright (c) 2015 S-Shimotori. All rights reserved.
//

import UIKit

class SODAxisLineView: UIView {
    var lineWidth: CGFloat = 1
    var lineColor = UIColor.blackColor()
}

class SODHorizontalAxisLineView: SODAxisLineView {
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        lineColor.set()
        CGContextSetLineWidth(context, lineWidth)
        CGContextMoveToPoint(context, 0, 0)
        CGContextAddLineToPoint(context, rect.width, 0)
        CGContextStrokePath(context)
    }
}

class SODVerticalAxisLineView: SODAxisLineView {
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        lineColor.set()
        CGContextSetLineWidth(context, lineWidth)
        CGContextMoveToPoint(context, rect.width, 0)
        CGContextAddLineToPoint(context, rect.width, rect.height)
        CGContextStrokePath(context)
    }
}