//
//  ViewController.swift
//  Sodalite
//
//  Created by S-Shimotori on 5/16/15.
//  Copyright (c) 2015 S-Shimotori. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sodaliteBarGraphView: SODBarGraphView!

    let horizontalTexts = ["Sun", "Mon", "Tue"]
    let data = [3.0, 8.0, 21.0]
    
    override func viewDidLayoutSubviews() {
        sodaliteBarGraphView.data = data
        
        sodaliteBarGraphView.hasVerticalAxis = true
        sodaliteBarGraphView.hasVerticalAxisScale = true
        sodaliteBarGraphView.verticalAxisAttributes = [
            NSFontAttributeName : UIFont.systemFontOfSize(10.0)
        ]
        sodaliteBarGraphView.verticalAxisScaleMax = 24
        sodaliteBarGraphView.verticalAxisScaleIncrement = 6
        
        sodaliteBarGraphView.horizontalAxisLabelTexts = horizontalTexts
        sodaliteBarGraphView.horizontalAxisAttributes = [
            NSFontAttributeName : UIFont.systemFontOfSize(15.0)
        ]
        sodaliteBarGraphView.draw()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

