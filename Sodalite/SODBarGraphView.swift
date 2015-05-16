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
        
        horizontalAxisView.frame = CGRectMake(0, 50, frame.width, 50)
        
        if hasVerticalAxis {
            graphView.frame = CGRectMake(50, 0, frame.width - 50, 50)
            verticalAxisView.frame = CGRectMake(0, 0, 50, 50)
            addSubview(verticalAxisView)
        } else {
            graphView.frame = CGRectMake(0, 0, frame.width, 50)
        }
        
        addSubview(horizontalAxisView)
        addSubview(graphView)
    }
    
    private func resetView() {
        subviews.map{$0.removeFromSuperview()}
    }

}
