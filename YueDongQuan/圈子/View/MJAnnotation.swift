//
//  MJAnnotation.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/28.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
import Foundation
import MapKit

class MJGreenAnnotation: NSObject,MKAnnotation {
    override init() {
        super.init()
    }
    var  coordinate = CLLocationCoordinate2D()
    var title: String? = nil
    var  subtitle: String? = nil
    
    
}

class MJRedAnnotation: NSObject,MKAnnotation {
    override init() {
        super.init()
    }
    var  coordinate = CLLocationCoordinate2D()
    var title: String? = nil
    var  subtitle: String? = nil
    
    
}