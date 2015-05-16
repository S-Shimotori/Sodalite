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
    
    override func viewDidLayoutSubviews() {
        sodaliteBarGraphView.hasVerticalAxis = false
        sodaliteBarGraphView.horizontalAxisLabelTexts = horizontalTexts
        sodaliteBarGraphView.horizontalAxisAttributes = [
            NSFontAttributeName : UIFont.systemFontOfSize(10.0)
        ]
        
        //sodaliteBarGraphView.backgroundColor = .grayColor()
        sodaliteBarGraphView.graphView.backgroundColor = UIColor.brownColor()
        
        //sodaliteBarGraphView.verticalAxisView.backgroundColor = .redColor()
        sodaliteBarGraphView.horizontalAxisView.backgroundColor = .blueColor()
        sodaliteBarGraphView.draw()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

