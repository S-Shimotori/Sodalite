//
//  SODGraphViewWithScale.swift
//  Sodalite
//
//  Created by S-Shimotori on 5/16/15.
//  Copyright (c) 2015 S-Shimotori. All rights reserved.
//

import UIKit

class SODGraphViewWithScale: UIView {

    var graphView = UIView()
    
    class SODAxisView: UIView {
        func sizeToFitSubviews() {
            var width: CGFloat = 0
            var height: CGFloat = 0
            
            for subview in subviews {
                width = max(width, subview.frame.origin.x + subview.frame.width)
                height = max(height, subview.frame.origin.y + subview.frame.height)
            }
            
            frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, height)
        }
    }
    var verticalAxisView = SODAxisView()
    var horizontalAxisView = SODAxisView()
    
    var data = [Double]()
    
    var hasVerticalAxis = true
    var hasVerticalAxisScale = true
    var verticalAxisScaleMax: Double?
    var verticalAxisScaleIncrement: Double?
    var verticalAxisAttributes = [NSObject : AnyObject]()
    
    var horizontalAxisLabelTexts = [String]()
    var horizontalAxisAttributes = [NSObject : AnyObject]()
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
