//
//  TempLeftViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/10/1.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class TempLeftViewController: MainViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let model = MJRequestModel()
        let v = 123
        let phone = "1234765526"
        let pw = "dkjhdkf"
        let describe = "苹果手机"
        model.VALIDATION_CODE = v
        model.phone = phone
        model.pw = pw
        model.describe = describe
        //登录操作
//        MJNetWorkHelper().loginWithUserInfo(login, userModel: model, success: { (responseDic, success) in
//            
//            }) { (error) in
//                
//        }
        self.showMJProgressHUD("我的等待视图")
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = true
        
    }
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
