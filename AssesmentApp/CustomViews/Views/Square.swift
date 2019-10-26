//
//  Square.swift
//  AssesmentApp
//
//  Created by Manish Sama on 10/25/19.
//  Copyright © 2019 Manish Sama. All rights reserved.
//

import Foundation
import UIKit

class Square: UIView {
    
    
    init(frame: CGRect, location: CGPoint) {
        super.init(frame: frame)
        self.center = location
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let beizerPath = UIBezierPath(rect: rect)
        UIColor.green.set()
        beizerPath.lineWidth = 2.0
        beizerPath.stroke()
    }
}
