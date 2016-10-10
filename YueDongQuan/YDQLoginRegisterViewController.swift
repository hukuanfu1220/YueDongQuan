//
//  YDQLoginRegisterViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/10/6.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class YDQLoginRegisterViewController: MainViewController,UITextFieldDelegate {
   var loginTextFeild  = MJLoginTextField()
    let loginView = LoginRegisterView(frame:CGRectZero)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view .addSubview(loginView)
        loginView.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.bottom.equalTo(0)
        }
       loginOrRigsterAction()
    }

    //MARK:登录和注册操作
    func loginOrRigsterAction()  {
        loginView.loginOrrigsterClosure = {(pramiters,type) in
            if type == 1 {
                MJNetWorkHelper().loginWithUserInfo(login, userModel: pramiters, success: { (responseDic, success) in
                    
                    }, fail: { (error) in
                        
                     print("返回错误信息",error)
                        self.dismissViewControllerAnimated(true, completion: nil)
                })
            }
            if type == 2 {
                MJNetWorkHelper().registerWithPhoneNumber(reg, phoneAndPwModel: pramiters, success: { (responseDic, success) in
                    
                    }, fail: { (error) in
                        
                    print("返回错误信息",error)
                        self.dismissViewControllerAnimated(true, completion: nil)
                })
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
