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
        if let lineWidth = lineWidth where lineWidth > 0 {
            self.lineWidth = lineWidth
        }
        if let lineColor = lineColor {
            self.lineColor = lineColor
        }
        
        super.init(frame: frame)
        backgroundColor = UIColor.clearColor()
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
        let line = UIBezierPath()
        line.moveToPoint(CGPointMake(0, 0));
        line.addLineToPoint(CGPointMake(rect.width, 0));
        lineColor.setStroke()
        //will draw half width line if not multiply 2
        line.lineWidth = lineWidth * 2
        line.stroke();
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
        let line = UIBezierPath()
        line.moveToPoint(CGPointMake(0, 0));
        line.addLineToPoint(CGPointMake(0, rect.height));
        lineColor.setStroke()
        //will draw half width line if not multiply 2
        line.lineWidth = lineWidth * 2
        line.stroke();
    }
}