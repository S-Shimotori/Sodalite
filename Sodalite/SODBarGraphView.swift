//
//  SodaliteBarGraphView.swift
//  Sodalite
//
//  Created by S-Shimotori on 5/16/15.
//  Copyright (c) 2015 S-Shimotori. All rights reserved.
//

import UIKit

class SODBarGraphView: SODGraphViewWithAxis {
    
    var barWidth: CGFloat?
    var barColor: UIColor?
    
    override func draw() {
        super.draw()
        let bars = Bars(frame: CGRectMake(
            0,
            0,
            graphView.frame.width,
            graphView.frame.height
            ), data: data, barWidth: barWidth, barColor: barColor, globalMaxValueInGraph: globalMaxValueInGraph)
        bars.backgroundColor = .clearColor()
        graphView.addSubview(bars)
    }

    class Bars: UIView {
        var data = [Double]()
        var barWidth: CGFloat = 0
        var barColor = UIColor.blackColor()
        var globalMaxValueInGraph: Double = 0
        
        init(frame: CGRect, data: [Double], barWidth: CGFloat?, barColor: UIColor?, globalMaxValueInGraph: Double?) {
            self.data = data
            
            if let barWidth = barWidth where barWidth > 0 {
                self.barWidth = barWidth
            } else {
                self.barWidth = frame.width / CGFloat(data.count * 2)
            }
            
            if let globalMaxValueInGraph = globalMaxValueInGraph {
                self.globalMaxValueInGraph = globalMaxValueInGraph > 0 ? globalMaxValueInGraph : 0
            } else {
                let maxValueOfData = maxElement(data)
                self.globalMaxValueInGraph = maxValueOfData > 0 ? maxValueOfData : 0
            }
            
            if let barColor = barColor {
                self.barColor = barColor
            }
            
            super.init(frame: frame)
        }
        
        required init(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        override func drawRect(rect: CGRect) {
            for i in 0..<data.count {
                let value = data[i] > 0 ? data[i] : 0
                let rectangle = UIBezierPath(rect: CGRectMake(
                    rect.width * CGFloat(i * 2 + 1) / CGFloat(data.count * 2) - barWidth / 2,
                    rect.height * CGFloat(1 - value / globalMaxValueInGraph),
                    barWidth,
                    rect.height * CGFloat(value / globalMaxValueInGraph)
                    ))
                rectangle.fill()
                barColor.setFill()
            }
        }
    }
}