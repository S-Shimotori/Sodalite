//
//  SODGraphView.swift
//  Sodalite
//
//  Created by S-Shimotori on 5/17/15.
//  Copyright (c) 2015 S-Shimotori. All rights reserved.
//

import UIKit

class SODGraphView: UIView {

    let graphView = UIView()

    //data to draw graph
    var data = [Double]()
    
    private func resetView() {
        subviews.map{$0.removeFromSuperview()}
    }
    
    func draw() {
        resetView()
        addSubview(graphView)
    }
}
