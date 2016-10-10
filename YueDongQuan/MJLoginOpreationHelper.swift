//
//  MJLoginOpreationHelper.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/30.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class MJLoginOpreationHelper: NSObject,RCIMUserInfoDataSource{
    //融云登录的token
    let mjToken = MJGetToken()
    var loginClourse : ((isLogin:Bool,userId:NSString) -> Void)?
    var errorLoginClourse : ((isLogin:Bool,errorValue:Int)->Void)?
    override init() {
        super.init()
      let token =  mjToken.requestTokenFromServeris("1231343121")
        RCIM.sharedRCIM().connectWithToken(token as String,
                                           success: { (userId) -> Void in
                                            
                                            RCIM.sharedRCIM().userInfoDataSource = self
                                            
                                            if let loginBlock = self.loginClourse{
                                                loginBlock(isLogin: true,userId: userId)
                                            }
                                            print("登陆成功。当前登录的用户ID：\(userId)")
            }, error: { (status) -> Void in
                print("登陆的错误码为:\(status.rawValue)")
                if let errorBlock = self.errorLoginClourse{
                    errorBlock(isLogin: false, errorValue: status.rawValue)
                }
            }, tokenIncorrect: {
                //token过期或者不正确。
                //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
                //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
                print("token错误")
        })
    }
    func getUserInfoWithUserId(userId: String!, completion: ((RCUserInfo!) -> Void)!) {
        /*
         //此处为了演示写了一个用户信息
         if ([@"1003" isEqual:userId]) {
         RCUserInfo *user = [[RCUserInfo alloc]init];
         user.userId = @"1003";
         user.name = @"jjjj";
         user.portraitUri = @"https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=1756054607,4047938258&fm=96&s=94D712D20AA1875519EB37BE0300C008";
         
         return completion(user);
         }else if([@"1003" isEqual:userId]) {
         RCUserInfo *user = [[RCUserInfo alloc]init];
         user.userId = @"1003";
         user.name = @"jjjj";
         user.portraitUri = @"https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=1756054607,4047938258&fm=96&s=94D712D20AA1875519EB37BE0300C008";
         return completion(user);
         }
         */
        let user = RCUserInfo()
        return completion(user)
        
    }
    
}
