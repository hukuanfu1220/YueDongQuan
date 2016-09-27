//
//  SendPhoneNumberView.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/19.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class SendPhoneNumberView: UIView {
    let kGAP =  10
    let kAvatar_Size = 40
    lazy var topLabel = UILabel()
    lazy var phoneNumber = UILabel()
    lazy var yanZhengMaLabel = UILabel()
     var yanZhengMaFeild = MJTextFeild()
    lazy var reSendBtn = UIButton()
    lazy var nextStapBtn = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self .addSubview(topLabel)
        self .addSubview(phoneNumber)
        self .addSubview(yanZhengMaLabel)
        
        self .addSubview(reSendBtn)
        self .addSubview(nextStapBtn)
        
        topLabel.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(ScreenHeight/10)
        }
        topLabel.text = "短信验证码已发送至"
        topLabel.textAlignment = .Center
        topLabel.textColor = UIColor.grayColor()
        phoneNumber.snp_makeConstraints { (make) in
            make.top.equalTo(topLabel.snp_bottom)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(ScreenHeight/10)
        }
        phoneNumber.text = "13556845876"
        phoneNumber.textAlignment = .Center
        phoneNumber.textColor = UIColor.grayColor()
        yanZhengMaLabel.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(phoneNumber.snp_bottom).offset(ScreenHeight/20)
            make.height.equalTo(ScreenHeight/10)
            make.width.equalTo(ScreenWidth/4.5)
        }
        yanZhengMaLabel.text = "验证码"
        yanZhengMaLabel.textAlignment = .Center
        yanZhengMaLabel.textColor = UIColor.grayColor()
        self .addSubview(yanZhengMaFeild)
        yanZhengMaFeild.snp_makeConstraints(closure: { (make) in
            make.left.equalTo(yanZhengMaLabel.snp_right)
            make.top.equalTo(phoneNumber.snp_bottom).offset(ScreenHeight/20)
            make.height.equalTo(ScreenHeight/20)
            make.right.equalTo(-20)
        })
        yanZhengMaFeild.placeholder = "填写短信验证码"
        
        reSendBtn.snp_makeConstraints { (make) in
            make.top.equalTo((yanZhengMaFeild.snp_bottom)).offset(kGAP)
            make.width.equalTo(ScreenWidth/3)
            make.height.equalTo(kGAP*2)
            make.right.equalTo(0)
        }
        reSendBtn.setTitle("未收到?重新发送", forState: UIControlState.Normal)
        reSendBtn.titleLabel?.textAlignment = .Left
        reSendBtn.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        
        let nextWidth = NSInteger(ScreenWidth) - kAvatar_Size*4
        nextStapBtn.snp_makeConstraints { (make) in
            make.width.equalTo(nextWidth)
            make.top.equalTo(reSendBtn.snp_bottom).offset(kGAP)
            make.left.equalTo(kAvatar_Size*2)
            make.height.equalTo(ScreenHeight/10)
        }
        nextStapBtn.setTitle("下一步", forState: .Normal)
//        nextStapBtn.tintColor = UIColor.blueColor()
        nextStapBtn.backgroundColor = UIColor.blueColor()
        nextStapBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        nextStapBtn.titleLabel?.font = UIFont.systemFontOfSize(20)
        nextStapBtn.titleLabel?.textAlignment = .Center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

}
