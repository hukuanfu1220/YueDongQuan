//
//  MJTextFeild.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/19.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class MJTextFeild: UITextField {


    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
       
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context!, UIColor.blueColor().CGColor)
        CGContextFillRect(context!, CGRectMake(0, CGRectGetHeight(self.frame)-0.5, CGRectGetWidth(self.frame), 0.5))
        
        
    }
   

}
