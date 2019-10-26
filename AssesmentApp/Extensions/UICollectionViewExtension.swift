//
//  UICollectionViewExtension.swift
//  AssesmentApp
//
//  Created by Manish Sama on 10/25/19.
//  Copyright © 2019 Manish Sama. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func registerCell<T>(a: T) {
        self.register(UINib(nibName: String(describing: T.self), bundle: nil), forCellWithReuseIdentifier: String(describing: T.self))
    }
    
}
