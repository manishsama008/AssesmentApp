//
//  SelfieImageObject.swift
//  AssesmentApp
//
//  Created by Manish Sama on 10/25/19.
//  Copyright © 2019 Manish Sama. All rights reserved.
//

import Foundation

struct SelfieImageObject {
    
    var imageUrl: String?
    
    init(json: [String: Any]) {
        self.imageUrl = json["webformatURL"] as? String
    }
}
