//
//  SODAxisLineView.swift
//  Sodalite
//
//  Created by S-Shimotori on 5/17/15.
//  Copyright (c) 2015 S-Shimotori. All rights reserved.
//

import UIKit

class SODAxisLineView: UIView {
    static let defaultLineWidth: CGFloat = 1
    
    var lineWidth: CGFloat = defaultLineWidth
    var lineColor = UIColor.blackColor()

    init(frame: CGRect, lineWidth: CGFloat?, lineColor: UIColor?) {
        if let lineWidth = lineWidth {
            self.lineWidth = lineWidth
        }
        if let lineColor = lineColor {
            self.lineColor = lineColor
        }
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class SODHorizontalAxisLineView: SODAxisLineView {
    
    override init(frame: CGRect, lineWidth: CGFloat?, lineColor: UIColor?) {
        super.init(frame: frame, lineWidth: lineWidth, lineColor: lineColor)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
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
    
    override init(frame: CGRect, lineWidth: CGFloat?, lineColor: UIColor?) {
        super.init(frame: frame, lineWidth: lineWidth, lineColor: lineColor)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        lineColor.set()
        CGContextSetLineWidth(context, lineWidth)
        CGContextMoveToPoint(context, rect.width, 0)
        CGContextAddLineToPoint(context, rect.width, rect.height)
        CGContextStrokePath(context)
    }
}