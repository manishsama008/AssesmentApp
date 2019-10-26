//
//  FirstViewController.swift
//  AssesmentApp
//
//  Created by Manish Sama on 10/24/19.
//  Copyright © 2019 Manish Sama. All rights reserved.
//

import UIKit

class DrawSquareViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapView(tapGesture:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapView(tapGesture: UITapGestureRecognizer) {
        drawView(location: tapGesture.location(in: self.view))
    }
    
    func drawView(location: CGPoint) {
        if !doesViewIntersect(location: location) {
            if checkIfTouchGoesOut(location: location) {
                showAlert()
                return
            }
            let square = Square(frame: CGRect(x: 0, y: 0, width: 100.0, height: 100.0), location: location)
            self.view.addSubview(square)
        }
    }
    
    func doesViewIntersect(location: CGPoint) -> Bool {
        for each in view.subviews {
            let convertView = view.convert(each.frame, from: each.superview)
            if convertView.contains(location) {
                return true
            }
        }
        return false
    }
    
    func checkIfTouchGoesOut(location: CGPoint) -> Bool {
        if (location.x - 50.0) < self.view.frame.origin.x || (location.x + 50.0) > self.view.frame.width {
            return true
        } else if (location.x - 50.0) < self.view.frame.origin.y || (location.x + 50.0) > self.view.frame.height {
            return true
        }
        return false
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Square", message: "Can't draw as it going out of screen", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

