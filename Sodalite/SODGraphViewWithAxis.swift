//
//  SODGraphViewWithScale.swift
//  Sodalite
//
//  Created by S-Shimotori on 5/16/15.
//  Copyright (c) 2015 S-Shimotori. All rights reserved.
//

import UIKit

class SODGraphViewWithAxis: UIView {

    //contains graph and axises
    var graphView = UIView()
    var verticalAxisView = SODAxisView()
    var horizontalAxisView = SODAxisView()
    
    //data to draw graph
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
            var paddingTop: CGFloat?
            
            if hasVerticalAxisScale {
                //set scale to vertical axis
                
                let maxValueOfData = maxElement(data)
                var scaleLabels = [UILabel]()
                
                if let verticalAxisScaleMax = verticalAxisScaleMax {
                    //set max scale to vertical axis
                    let label = UILabel()
                    label.attributedText = NSAttributedString(string: "\(verticalAxisScaleMax)", attributes: verticalAxisAttributes)
                    label.sizeToFit()
                    if maxValueOfData <= verticalAxisScaleMax {
                        label.frame.origin = CGPointMake(0, 0)
                        paddingTop = label.frame.height / 2
                    } else {
                        label.frame.origin.x = 0
                        label.center.y = (frame.height - horizontalAxisView.frame.height) * (1 - CGFloat(verticalAxisScaleMax) / CGFloat(maxValueOfData))
                    }
                    scaleLabels.append(label)
                    verticalAxisView.addSubview(label)
                }
                
                if let verticalAxisScaleIncrement = verticalAxisScaleIncrement {
                    //set scale to vertical axis
                    let maxValueOfScale: Double!
                    if let verticalAxisScaleMax = verticalAxisScaleMax {
                        maxValueOfScale = max(verticalAxisScaleMax, maxValueOfData)
                    } else {
                        maxValueOfScale = maxValueOfData
                    }
                    
                    var scaleValue = verticalAxisScaleIncrement
                    while scaleValue < maxValueOfScale {
                        let label = UILabel()
                        label.attributedText = NSAttributedString(string: "\(scaleValue)", attributes: verticalAxisAttributes)
                        label.sizeToFit()
                        label.frame.origin.x = 0
                        //cause error if calculate y-coordinate with one statement
                        label.center.y =
                            (frame.height - horizontalAxisView.frame.height - (paddingTop ?? 0))
                            * (1 - CGFloat(scaleValue)
                            / CGFloat(maxValueOfScale))
                        label.center.y += paddingTop ?? 0
                        scaleLabels.append(label)
                        verticalAxisView.addSubview(label)
                        scaleValue += verticalAxisScaleIncrement
                    }
                }
                
                //calculate verticalAxis width
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
            
            verticalAxisView.axisLine = SODVerticalAxisLineView(frame: CGRectMake(
                verticalAxisView.frame.width,
                paddingTop ?? 0,
                1,
                verticalAxisView.frame.height - (paddingTop ?? 0)))
            verticalAxisView.addSubview(verticalAxisView.axisLine!)
            
            horizontalAxisView.frame = CGRectMake(
                verticalAxisView.frame.width,
                frame.height - horizontalAxisView.frame.height,
                frame.width - verticalAxisView.frame.width,
                horizontalAxisView.frame.height
            )
            graphView.frame = CGRectMake(
                verticalAxisView.frame.width,
                paddingTop ?? 0,
                frame.width - verticalAxisView.frame.width,
                frame.height - horizontalAxisView.frame.height - (paddingTop ?? 0)
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
        
        //draw axis lines
        horizontalAxisView.axisLine = SODHorizontalAxisLineView(frame: CGRectMake(0, 0, horizontalAxisView.frame.width, 1))
        horizontalAxisView.addSubview(horizontalAxisView.axisLine!)
        
        addSubview(horizontalAxisView)
        addSubview(graphView)
    }

}
