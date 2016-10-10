//
//  MJModel.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/26.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class MJModel: NSObject {
    //返回接口验证码
    var VALIDATION_CODE = 1234
    //返回码
    var RESULT_CODE = NSInteger()
    // 用户ID
    var uid = ""
}

class  MJRequestModel: MJModel {
    /*用户登录 login*/
    //电话号码
    var phone = ""
    //密码
    var pw = ""
    //登录手机信息描述
    var describe = ""
}

class MJResponse: MJModel {
    
}
