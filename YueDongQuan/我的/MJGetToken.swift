//
//  MJGetToken.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/30.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class MJGetToken: NSObject {

    var token : NSString!
    override init() {
        super.init()
    }
    
    func requestTokenFromServeris(token:NSString) -> NSString {
        self.token = token
        return "51QYR6mzRjDe4i7kYE/yJOJ3v5Zd9nEe9dx0FRD0W7m5tmpOzv3HZ0GSQLV7QpoSYkBrgoICZR8EbovC6fH3rA=="
    }
}
