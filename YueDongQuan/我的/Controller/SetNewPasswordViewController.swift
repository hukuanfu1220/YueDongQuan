//
//  SetNewPasswordViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/19.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class SetNewPasswordViewController: MainViewController {

    lazy var newPassWordLabel = UIButton(type: UIButtonType.Custom)
    lazy var sureNewPassWordLabel = UIButton(type: UIButtonType.Custom)
     var newPassWordFeild = MJTextFeild()
     var sureNewPassWordField = MJTextFeild()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
self.view .addSubview(newPassWordLabel)
        self.view .addSubview(sureNewPassWordLabel)
        self.view .addSubview(newPassWordFeild)
        self.view .addSubview(sureNewPassWordField)
        //新密码
        newPassWordLabel.snp_makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.width.equalTo(ScreenWidth/5)
            make.height.equalTo(ScreenHeight/15)
        }
        newPassWordLabel.setTitle("新密码", forState: UIControlState.Normal)
//        newPassWordLabel.backgroundColor = UIColor.redColor()
        newPassWordLabel.userInteractionEnabled = false
        newPassWordLabel.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        newPassWordLabel.contentVerticalAlignment = .Bottom
//        newPassWordLabel.adjustsFontSizeToFitWidth = true
        //确认新密码
        sureNewPassWordLabel.snp_makeConstraints { (make) in
            make.top.equalTo(newPassWordLabel.snp_bottom)
            make.left.equalTo(0)
            make.width.equalTo(ScreenWidth/5)
            make.height.equalTo(ScreenHeight/15)
        }
        sureNewPassWordLabel.setTitle("确认密码", forState: UIControlState.Normal)
        sureNewPassWordLabel.userInteractionEnabled = false
        sureNewPassWordLabel.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
       sureNewPassWordLabel.contentVerticalAlignment = .Bottom
        
//        sureNewPassWordLabel.adjustsFontSizeToFitWidth = true
        
        //新密码输入框
        newPassWordFeild.snp_makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(newPassWordLabel.snp_right)
            make.right.equalTo(-10)
            make.height.equalTo(ScreenHeight/15)
        }
        newPassWordFeild.placeholder = "请输入新密码"
        
        //确认新密码
        sureNewPassWordField.snp_makeConstraints { (make) in
            make.top.equalTo(newPassWordFeild.snp_bottom)
            make.left.equalTo(sureNewPassWordLabel.snp_right)
            make.right.equalTo(-10)
            make.height.equalTo(ScreenHeight/15)
        }
        sureNewPassWordField.placeholder = "确认密码"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
