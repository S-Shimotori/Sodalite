//
//  SODGraphViewWithScale.swift
//  Sodalite
//
//  Created by S-Shimotori on 5/16/15.
//  Copyright (c) 2015 S-Shimotori. All rights reserved.
//

import UIKit

class SODGraphViewWithAxis: SODGraphView {

    //contains axises
    let verticalAxisView = SODAxisView()
    let horizontalAxisView = SODAxisView()

    //contains horizontal lines under graphView
    private let linesUnderGraphView = SODLinesUnderGraphView()

    private var _axisLinesWidth = SODAxisLineView.defaultLineWidth
    var axisLinesWidth: CGFloat {
        get {
            return _axisLinesWidth
        }
        set(newValue) {
            if newValue >= 0 {
                _axisLinesWidth = newValue
            } else {
                println("invalid axisLinesWidth: negative values are not allowed.")
            }
        }
    }
    var axisLinesColor: UIColor?
    var hasVerticalAxis = true
    var hasVerticalAxisScaleLabels = true
    var maxValueOfVerticalAxisScale: Double?
    var incrementOfVerticalAxisScale: Double?

    var constantValuesOfVerticalAxisScaleLines = [Double]()
    var verticalAxisScaleLinesWidth: CGFloat?
    var verticalAxisScaleLinesColor: UIColor?
    var verticalAxisScaleLabelTextAttributes = [NSObject : AnyObject]()
    
    var horizontalAxisLabelTexts = [String]()
    var horizontalAxisScaleLabelTextAttributes = [NSObject : AnyObject]()
   
    var hasHorizontalScaleLines = true
    var horizontalScaleLinesIncrement: Double?

    func drawScale() {
        
        //to set label.frame after calculating verticalAxisView.frame
        var horizontalAxisLabels = [UILabel]()
        
        for text in horizontalAxisLabelTexts {
            let label = UILabel()
            label.attributedText = NSAttributedString(string: text, attributes: horizontalAxisScaleLabelTextAttributes)
            label.sizeToFit()
            label.frame.origin.y = axisLinesWidth
            
            horizontalAxisLabels.append(label)
            horizontalAxisView.addSubview(label)
        }
        horizontalAxisView.sizeToFitSubviews()
        horizontalAxisView.frame.size.width += axisLinesWidth
        if hasVerticalAxis {
            var paddingTop: CGFloat?
            
            if hasVerticalAxisScaleLabels {
                //set scale to vertical axis
                let maxValueOfData = maxElement(data)
                let uIntMaxValueOfData = maxValueOfData > 0 ? maxValueOfData : 0
                var scaleLabels = [UILabel]()
                
                if let maxValueOfVerticalAxisScale = maxValueOfVerticalAxisScale where maxValueOfVerticalAxisScale > 0 {
                    //set max scale to vertical axis
                    let label = UILabel()
                    label.attributedText = NSAttributedString(string: "\(maxValueOfVerticalAxisScale)", attributes: verticalAxisScaleLabelTextAttributes)
                    label.sizeToFit()
                    if uIntMaxValueOfData <= maxValueOfVerticalAxisScale {
                        label.frame.origin = CGPointMake(0, 0)
                        paddingTop = label.frame.height / 2
                    } else {
                        label.frame.origin.x = 0
                        label.center.y = (frame.height - horizontalAxisView.frame.height) * (1 - CGFloat(maxValueOfVerticalAxisScale) / CGFloat(uIntMaxValueOfData))
                    }
                    scaleLabels.append(label)
                    verticalAxisView.addSubview(label)
                }
                
                if let incrementOfVerticalAxisScale = incrementOfVerticalAxisScale where incrementOfVerticalAxisScale > 0 {
                    //set scale to vertical axis
                    let maxValueOfScale: Double!
                    if let maxValueOfVerticalAxisScale = maxValueOfVerticalAxisScale {
                        maxValueOfScale = max(maxValueOfVerticalAxisScale, uIntMaxValueOfData)
                    } else {
                        maxValueOfScale = uIntMaxValueOfData
                    }
                    
                    var scaleValue = incrementOfVerticalAxisScale
                    while scaleValue < maxValueOfScale {
                        let label = UILabel()
                        label.attributedText = NSAttributedString(string: "\(scaleValue)", attributes: verticalAxisScaleLabelTextAttributes)
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
                        scaleValue += incrementOfVerticalAxisScale
                    }
                }
                
                //calculate verticalAxis width
                if incrementOfVerticalAxisScale != nil {
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
            verticalAxisView.frame.size.width += axisLinesWidth
            verticalAxisView.frame.size.height = frame.height - horizontalAxisView.frame.height + axisLinesWidth
            addSubview(verticalAxisView)
            
            verticalAxisView.axisLine = SODVerticalAxisLineView(frame: CGRectMake(
                verticalAxisView.frame.width - axisLinesWidth,
                paddingTop ?? 0,
                axisLinesWidth,
                verticalAxisView.frame.height - (paddingTop ?? 0)),
                lineWidth: axisLinesWidth, lineColor: axisLinesColor
            )
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

        linesUnderGraphView.backgroundColor = .clearColor()
        linesUnderGraphView.frame = graphView.frame
        linesUnderGraphView.globalMaxValueInGraph = globalMaxValueInGraph()
        if let verticalAxisScaleLinesWidth = verticalAxisScaleLinesWidth where verticalAxisScaleLinesWidth > 0 {
            linesUnderGraphView.lineWidth = verticalAxisScaleLinesWidth
        }
        if let verticalAxisScaleLinesColor = verticalAxisScaleLinesColor {
            linesUnderGraphView.lineColor = verticalAxisScaleLinesColor
        }

        var horizontalScaleLinesValue = constantValuesOfVerticalAxisScaleLines
        if let horizontalScaleLinesIncrement = horizontalScaleLinesIncrement where horizontalScaleLinesIncrement > 0 {
            var scaleValue = horizontalScaleLinesIncrement
            
            while scaleValue < globalMaxValueInGraph() {
                horizontalScaleLinesValue.append(scaleValue)
                scaleValue += horizontalScaleLinesIncrement
            }
        }
        linesUnderGraphView.data = horizontalScaleLinesValue
        addSubview(linesUnderGraphView)
        sendSubviewToBack(linesUnderGraphView)

        
        for i in 0..<horizontalAxisLabels.count {
            horizontalAxisLabels[i].center.x = horizontalAxisView.frame.width * CGFloat(i * 2 + 1) / CGFloat(horizontalAxisLabelTexts.count * 2)
        }
        
        //draw axis lines
        horizontalAxisView.axisLine = SODHorizontalAxisLineView(frame:CGRectMake(
            0,
            0,
            horizontalAxisView.frame.width,
            axisLinesWidth),
            lineWidth: axisLinesWidth, lineColor: axisLinesColor)
        horizontalAxisView.addSubview(horizontalAxisView.axisLine!)
        
        addSubview(horizontalAxisView)
    }
    
    override func draw() {
        super.draw()
        drawScale()
    }

    func globalMaxValueInGraph() -> Double {
        var values = [Double]()
        values += data
        values.append(0)
        if let maxValueOfVerticalAxisScale = maxValueOfVerticalAxisScale {
            values.append(maxValueOfVerticalAxisScale)
        }
        
        return maxElement(values)
    }
    
    class SODLinesUnderGraphView: UIView {
        var lineWidth: CGFloat = 1
        var lineColor = UIColor.blackColor()
        var data = [Double]()
        var globalMaxValueInGraph: Double = 0
        override func drawRect(rect: CGRect) {
            backgroundColor = .clearColor()
            lineColor.setStroke()
            for value in data {
                if 0 < value && value <= globalMaxValueInGraph {
                    let line = UIBezierPath()
                    let y = rect.height * CGFloat(1 - value / globalMaxValueInGraph)
                    line.moveToPoint(CGPointMake(0, y))
                    line.addLineToPoint(CGPointMake(rect.width, y))
                    line.lineWidth = lineWidth
                    line.stroke();
                }
            }
        }
    }
}
