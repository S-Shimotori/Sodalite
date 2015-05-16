//
//  SodaliteBarGraphView.swift
//  Sodalite
//
//  Created by S-Shimotori on 5/16/15.
//  Copyright (c) 2015 S-Shimotori. All rights reserved.
//

import UIKit

class SODBarGraphView: SODGraphViewWithScale, SODDrawable {
    
    func draw() {
        resetView()
        
        for i in 0..<horizontalAxisLabelTexts.count {
            let text = horizontalAxisLabelTexts[i]
            
            let label = UILabel()
            label.attributedText = NSAttributedString(string: text, attributes: horizontalAxisAttributes)
            label.sizeToFit()
            label.center.x = frame.width * CGFloat(i * 2 + 1) / CGFloat(horizontalAxisLabelTexts.count * 2)
            label.frame.origin.y = 0
            
            horizontalAxisView.addSubview(label)
        }
        horizontalAxisView.sizeToFit()

        horizontalAxisView.frame = CGRectMake(0, frame.height - horizontalAxisView.frame.height, frame.width, horizontalAxisView.frame.height)
        
        if hasVerticalAxis {
            graphView.frame = CGRectMake(50, 0, frame.width - 50, 50)
            verticalAxisView.frame = CGRectMake(0, 0, 50, 50)
            addSubview(verticalAxisView)
        } else {
            graphView.frame = CGRectMake(0, 0, frame.width, frame.height - horizontalAxisView.frame.height)
        }

        addSubview(horizontalAxisView)
        addSubview(graphView)
    }
    
    private func resetView() {
        subviews.map{$0.removeFromSuperview()}
    }

}
