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
        
        //to set label.frame after calculating verticalAxisView.frame
        var horizontalAxisLabels = [UILabel]()
        
        for text in horizontalAxisLabelTexts {
            let label = UILabel()
            label.attributedText = NSAttributedString(string: text, attributes: horizontalAxisAttributes)
            label.sizeToFit()
            //set temporary x-coordinate
            label.frame.origin = CGPointMake(0, 0)
            
            horizontalAxisLabels.append(label)
            horizontalAxisView.addSubview(label)
        }
        horizontalAxisView.sizeToFitSubviews()
        horizontalAxisView.frame.size.width += 1
        
        if hasVerticalAxis {
            if hasVerticalAxisScale {
                let maxValueOfData = maxElement(data)
                var scaleLabels = [UILabel]()
                
                if let verticalAxisScaleMax = verticalAxisScaleMax {
                    let label = UILabel()
                    label.attributedText = NSAttributedString(string: "\(verticalAxisScaleMax)", attributes: verticalAxisAttributes)
                    label.sizeToFit()
                    if maxValueOfData <= verticalAxisScaleMax {
                        label.frame.origin = CGPointMake(0, 0)
                    } else {
                        label.frame.origin.x = 0
                        label.center.y = (frame.height - horizontalAxisView.frame.height) * (1 - CGFloat(verticalAxisScaleMax) / CGFloat(maxValueOfData))
                    }
                    scaleLabels.append(label)
                    verticalAxisView.addSubview(label)
                }
                
                if let verticalAxisScaleIncrement = verticalAxisScaleIncrement {
                    let maxScaleValue: Double!
                    if let verticalAxisScaleMax = verticalAxisScaleMax {
                        maxScaleValue = max(verticalAxisScaleMax, maxValueOfData)
                    } else {
                        maxScaleValue = maxValueOfData
                    }
                    var scaleValue = verticalAxisScaleIncrement
                    
                    while scaleValue < maxScaleValue {
                        let label = UILabel()
                        label.attributedText = NSAttributedString(string: "\(scaleValue)", attributes: verticalAxisAttributes)
                        label.sizeToFit()
                        label.frame.origin.x = 0
                        label.center.y = (frame.height - horizontalAxisView.frame.height) * (1 - CGFloat(scaleValue) / CGFloat(maxScaleValue))
                        scaleLabels.append(label)
                        verticalAxisView.addSubview(label)
                        scaleValue += verticalAxisScaleIncrement
                    }
                }
                
                if verticalAxisScaleIncrement != nil {
                    var maxScaleLabelWidth = CGFloat.min
                    for label in scaleLabels {
                        maxScaleLabelWidth = max(maxScaleLabelWidth, label.frame.width)
                    }
                    for label in scaleLabels {
                        label.frame.origin.x = maxScaleLabelWidth - label.frame.width
                    }
                }
            }
            verticalAxisView.sizeToFitSubviews()
            verticalAxisView.frame.origin = CGPointMake(0, 0)
            verticalAxisView.frame.size.width += 1
            verticalAxisView.frame.size.height = frame.height - horizontalAxisView.frame.height
            addSubview(verticalAxisView)
            
            horizontalAxisView.frame = CGRectMake(
                verticalAxisView.frame.width,
                frame.height - horizontalAxisView.frame.height,
                frame.width - verticalAxisView.frame.width,
                horizontalAxisView.frame.height
            )
            graphView.frame = CGRectMake(
                verticalAxisView.frame.width,
                0,
                frame.width - verticalAxisView.frame.width,
                frame.height - horizontalAxisView.frame.height
            )
        } else {
            horizontalAxisView.frame = CGRectMake(
                0,
                frame.height - horizontalAxisView.frame.height,
                frame.width,
                horizontalAxisView.frame.height
            )
            graphView.frame = CGRectMake(
                0,
                0,
                frame.width,
                frame.height - horizontalAxisView.frame.height
            )
        }
        
        for i in 0..<horizontalAxisLabels.count {
            horizontalAxisLabels[i].center.x = horizontalAxisView.frame.width * CGFloat(i * 2 + 1) / CGFloat(horizontalAxisLabelTexts.count * 2)
        }
        horizontalAxisView.axisLine = SODHorizontalAxisLineView(frame: CGRectMake(0, 0, horizontalAxisView.frame.width, 1))
        horizontalAxisView.addSubview(horizontalAxisView.axisLine!)
        verticalAxisView.axisLine = SODVerticalAxisLineView(frame: CGRectMake(verticalAxisView.frame.width, 0, 1, verticalAxisView.frame.height))
        verticalAxisView.addSubview(verticalAxisView.axisLine!)
        addSubview(horizontalAxisView)
        addSubview(graphView)
    }

}
