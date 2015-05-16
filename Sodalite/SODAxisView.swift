//
//  SODAxisView.swift
//  Sodalite
//
//  Created by S-Shimotori on 5/17/15.
//  Copyright (c) 2015 S-Shimotori. All rights reserved.
//

import UIKit

class SODAxisView: UIView {
    var scaleValues = [Double]()
    var axisLine: SODAxisLineView?
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