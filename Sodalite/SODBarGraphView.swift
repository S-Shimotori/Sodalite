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
        drawScale()
    }

}
