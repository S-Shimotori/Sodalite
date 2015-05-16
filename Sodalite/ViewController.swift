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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        sodaliteBarGraphView.backgroundColor = .grayColor()
        sodaliteBarGraphView.graphView.backgroundColor = .whiteColor()
        sodaliteBarGraphView.verticalAxisView.backgroundColor = .redColor()
        sodaliteBarGraphView.horizontalAxisView.backgroundColor = .blueColor()
        sodaliteBarGraphView.draw()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

