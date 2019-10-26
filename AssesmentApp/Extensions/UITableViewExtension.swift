//
//  UITableViewExtension.swift
//  AssesmentApp
//
//  Created by Manish Sama on 10/25/19.
//  Copyright © 2019 Manish Sama. All rights reserved.
//

import Foundation

import UIKit

extension UITableView {
    
    func registerCell<T>(a: T) {
        self.register(UINib(nibName: String(describing: T.self), bundle: nil), forCellReuseIdentifier: String(describing: T.self))
    }
    
}
