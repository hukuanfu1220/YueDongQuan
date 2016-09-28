//
//  MJAnnotationView.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/28.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit
//大头针视图的类型 红色和绿色
enum MJAnnotationViewType {
    case Green
    case Red
}


class MJAnnotationView: MAAnnotationView {
    
    var viewType = MJAnnotationViewType?.self
    //自定义初始化
    
    init!(annotation: MAAnnotation!, reuseIdentifier: String!,viewType:MJAnnotationViewType) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        if viewType == MJAnnotationViewType.Green {
            self.image = UIImage(named: "img_putongquanzi")
        }else{
            self.image = UIImage(named: "img_simiquanzi")
        }
        
        self.annotation = annotation
        self.canShowCallout = true
        self.calloutOffset = CGPoint(x: -5, y: 0)

    }
    
    
       
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
