//
//  SODGraphViewWithScale.swift
//  Sodalite
//
//  Created by S-Shimotori on 5/16/15.
//  Copyright (c) 2015 S-Shimotori. All rights reserved.
//

import UIKit

class SODGraphViewWithAxis: UIView {

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
    
    func resetView() {
        subviews.map{$0.removeFromSuperview()}
    }
    
    func drawScale() {
        for i in 0..<horizontalAxisLabelTexts.count {
            let text = horizontalAxisLabelTexts[i]
            
            let label = UILabel()
            label.attributedText = NSAttributedString(string: text, attributes: horizontalAxisAttributes)
            label.sizeToFit()
            label.center.x = frame.width * CGFloat(i * 2 + 1) / CGFloat(horizontalAxisLabelTexts.count * 2)
            label.frame.origin.y = 0
            
            horizontalAxisView.addSubview(label)
        }
        horizontalAxisView.sizeToFitSubviews()
        
        if hasVerticalAxis {
            if hasVerticalAxisScale {
                if let verticalAxisScaleMax = verticalAxisScaleMax {
                    let label = UILabel()
                    label.attributedText = NSAttributedString(string: "\(verticalAxisScaleMax)", attributes: verticalAxisAttributes)
                    label.sizeToFit()
                    let maxValueOfData = minElement(data)
                    if maxValueOfData <= verticalAxisScaleMax {
                        label.frame.origin = CGPointMake(0, 0)
                    } else {
                        label.frame.origin.x = 0
                        label.center.y = (frame.height - horizontalAxisView.frame.height) * CGFloat(verticalAxisScaleMax) / CGFloat(maxValueOfData)
                    }
                    verticalAxisView.addSubview(label)
                }
            } else {
                
            }
            verticalAxisView.sizeToFitSubviews()
            verticalAxisView.frame = CGRectMake(0, 0, verticalAxisView.frame.width, verticalAxisView.frame.height)
            addSubview(verticalAxisView)
            
            graphView.frame = CGRectMake(verticalAxisView.frame.width, 0, frame.width - verticalAxisView.frame.width, frame.height - horizontalAxisView.frame.height)
        } else {
            graphView.frame = CGRectMake(0, 0, frame.width, frame.height - horizontalAxisView.frame.height)
        }
        
        horizontalAxisView.frame = CGRectMake(verticalAxisView.frame.width, frame.height - horizontalAxisView.frame.height, frame.width - verticalAxisView.frame.width, horizontalAxisView.frame.height)
        addSubview(horizontalAxisView)
        addSubview(graphView)
    }

}
