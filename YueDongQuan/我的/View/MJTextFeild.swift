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
        CGContextSetFillColorWithColor(context!, kBlueColor.CGColor)
        CGContextFillRect(context!, CGRectMake(0, CGRectGetHeight(self.frame)-0.5, CGRectGetWidth(self.frame), 0.5))
        
        
    }
    
}
class MJLoginTextField: UITextField {
    //边框颜色
    var borderFillColor : UIColor!

    override func drawRect(rect: CGRect) {

        self.tintColor = UIColor.whiteColor()
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context!, borderFillColor.CGColor)
        CGContextFillRect(context!, CGRectMake(0, CGRectGetHeight(self.frame)-2, CGRectGetWidth(self.frame), 2))
        CGContextFillRect(context!, CGRectMake(0, CGRectGetHeight(self.frame)-10, 2, 10))
        CGContextFillRect(context!, CGRectMake(self.frame.width-2, CGRectGetHeight(self.frame)-10, 2, 10))
   
    }
    
    override class func initialize () {
        getIvars()
    }
    
    /**
     runtime
     */
    class func getPropertyList() {
        var count: UInt32 = 0
        // 获取属性列表
        let pros = class_copyPropertyList(UITextField.classForCoder(), &count) // 这里不能使用self
        for i in 0..<count {
            let pro = pros[Int(i)]
            let name = property_getName(pro)
            if let proName = String.fromCString(name) {
                let proType = String.fromCString(property_getAttributes(pro))
                debugPrint("\(proName)====\((proType!))")
            }
        }
    }
    
    class func getIvars() {
        var count: UInt32 = 0
        // 获取成员变量列表
        let ivars = class_copyIvarList(UITextField.classForCoder(), &count)
        for i in 0..<count {
            let ivar = ivars[Int(i)]
            
            let name = ivar_getName(ivar)
            
            if let ivarName = String.fromCString(name) {
                let ivarType = String.fromCString(ivar_getTypeEncoding(ivar))
                debugPrint("\(ivarName)===\(ivarType!)")
            }
        }
    }
    
}
