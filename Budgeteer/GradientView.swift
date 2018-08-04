//
//  GradientView.swift
//  Cnected
//
//  Created by Brendon Warwick on 03/06/2018.
//  Copyright © 2018 FV iMAGINATION. All rights reserved.
//

import Foundation
import UIKit

class GradientView: UIView {
    override open class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let gradientLayer = layer as! CAGradientLayer
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [DEEPER_BLUE,
                                BUDGET_BLACK]
    }
}

