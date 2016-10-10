//
//  LoginRegisterView.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/10/6.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class LoginRegisterView: UIView,UITextFieldDelegate {
    
    //点击登录和注册时使用闭包传参数值
    typealias LoginOrRigsterClosure = (pramiters:NSDictionary,type:NSInteger) -> Void //声明闭包，点击按钮传值
    //把申明的闭包设置成属性
    var loginOrrigsterClosure: LoginOrRigsterClosure?
    
    var ref = MJLineRef()
    let margin = (ScreenWidth-ScreenWidth/3.5*2)/3
    let topView = UIImageView()
    let loginBtn = UIButton(type: .Custom)
    var bgScrollView = UIScrollView(frame: CGRectZero)
    //手机号码占位符
    var acountPlace : placerholderLabel!
    //密码占位符
    var pwPlace : placerholderLabel!
    // 新用户手机号码占位符
    var newAcountPlace : placerholderLabel!
    //验证码占位符
    var maskCodePlace : placerholderLabel!
    //设置密码占位符
    var settingPwPlace : placerholderLabel!
    //用户登录时的model
    let userModel = MJRequestModel()
    //注册model
    let registerModel = MJRequestModel()
    override init(frame: CGRect) {
        super.init(frame: frame)
       createTopView()
    }
    func createTopView()  {
        //背景图
        
        topView.frame = CGRectMake(0,0,ScreenWidth,ScreenHeight/2.5)
        topView.image = UIImage(named: "篮球@2x")
        topView.userInteractionEnabled = true
        self .addSubview(topView)
      
        //头像
        let headImage = UIImageView()
        topView .addSubview(headImage)
        headImage.snp_makeConstraints { (make) in
            make.width.height.equalTo(ScreenWidth/3.5)
            make.centerX.equalTo(topView.snp_centerX)
            make.centerY.equalTo(topView.snp_centerY)
        }
        headImage.layer.cornerRadius = ScreenWidth/3.5/2
        headImage.layer.masksToBounds = true
        headImage.layer.borderWidth = 1
        headImage.backgroundColor = kBlueColor
        headImage.layer.borderColor = UIColor.whiteColor().CGColor
        
       
        loginBtn.frame = CGRectMake(margin, topView.frame.height-35, ScreenWidth/3.5, 30)
        loginBtn.tag = 10
        loginBtn .addTarget(self, action: #selector(btnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        topView .addSubview(loginBtn)
        
        loginBtn.setTitle("登录", forState: UIControlState.Normal)
//        loginBtn.titleLabel?.adjustsFontSizeToFitWidth = true
//        loginBtn.titleLabel?.font = UIFont.systemFontOfSize(kTopScaleOfFont)
        loginBtn.contentVerticalAlignment = .Top
        let registBtn = UIButton(type: .Custom)
        registBtn.frame = CGRectMake(loginBtn.frame.width+margin*2, topView.frame.height-35, ScreenWidth/3.5, 30)
        registBtn.addTarget(self, action: #selector(btnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        registBtn.tag = 20
        topView .addSubview(registBtn)

        registBtn.setTitle("注册", forState: UIControlState.Normal)
        registBtn.contentVerticalAlignment = .Top

        ref.frame = CGRectMake(margin, topView.frame.height-2, ScreenWidth/3.5, 2)
        topView .addSubview(ref)
        ref.backgroundColor = UIColor.yellowColor()
      
        //下面登录注册
        
        
        self .addSubview(bgScrollView)
        bgScrollView.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(topView.snp_bottom)
            make.bottom.equalTo(0)
        }
        bgScrollView.contentSize = CGSizeMake(ScreenWidth*2, ScreenHeight-topView.height)
            bgScrollView.backgroundColor = UIColor(red: 38 / 255, green: 43/255, blue: 44/255, alpha: 1)
        bgScrollView.scrollEnabled = false
        
        //帐号输入框
        let acountTextField = MJLoginTextField()
        acountTextField.borderFillColor = UIColor.whiteColor()
        acountTextField.keyboardType = .NumberPad
        bgScrollView .addSubview(acountTextField)
        acountTextField.snp_makeConstraints { (make) in
            make.left.equalTo(margin)
            make.width.equalTo(ScreenWidth-margin*2)
            make.top.equalTo(10)
            make.height.equalTo(40)
        }
        let leftV1 = UIImageView(frame: CGRectMake(0, 0, 40, 40))
        leftV1.image = UIImage(named: "ic_fabu_0088ff")
        acountTextField.leftViewMode = .Always
        acountTextField.leftView = leftV1
        acountTextField.delegate = self
        acountTextField.tag = 10
        
        acountPlace = placerholderLabel(frame: CGRectMake(50, 0, 100, 40), string: "手机号码")
            acountTextField .addSubview(acountPlace)
        //密码输入框
        let pwTextfeild = MJLoginTextField()
        pwTextfeild.borderFillColor = UIColor.whiteColor()
        pwTextfeild.secureTextEntry = true
        bgScrollView .addSubview(pwTextfeild)
        pwTextfeild.snp_makeConstraints { (make) in
            make.left.equalTo(margin)
            make.width.equalTo(ScreenWidth-margin*2)
            make.top.equalTo(acountTextField.snp_bottom).offset(margin)
            make.height.equalTo(40)
        }
        pwTextfeild.tag = 20
        pwTextfeild.delegate = self
        pwPlace = placerholderLabel(frame: CGRectMake(50, 0, 100, 40), string: "密码")
        pwTextfeild .addSubview(pwPlace)
        //登录
        let loginActBtn = UIButton(type: .Custom)
        
        bgScrollView .addSubview(loginActBtn)
        loginActBtn.snp_makeConstraints { (make) in
            make.left.equalTo(margin)
            make.width.equalTo(ScreenWidth-margin*2)
            make.top.equalTo(pwTextfeild.snp_bottom).offset(margin)
            make.height.equalTo(40)
        }
        loginActBtn.layer.cornerRadius = 5
        loginActBtn.layer.masksToBounds = true
        loginActBtn.backgroundColor = kBlueColor
        loginActBtn.setTitle("登录", forState: UIControlState.Normal)
        loginActBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        loginActBtn .addTarget(self, action: #selector(loginAction), forControlEvents: UIControlEvents.TouchUpInside)
        
        //忘记密码
        let forgetPw = UIButton(type: .Custom)
        bgScrollView .addSubview(forgetPw)
        forgetPw.snp_makeConstraints { (make) in
            make.left.equalTo(margin)
            make.width.equalTo(ScreenWidth-margin*2)
            make.top.equalTo(loginActBtn.snp_bottom).offset(10)
            make.height.equalTo(40)
        }
        forgetPw.setTitle("忘记密码？", forState: UIControlState.Normal)
        forgetPw.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        //手机号码
        // 添加通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TextFieldTextDidChange), name: UITextFieldTextDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TextDidEndEditing), name: UITextFieldTextDidEndEditingNotification, object: nil)
        
        let phoneNumber = MJLoginTextField()
        phoneNumber.borderFillColor = UIColor.whiteColor()
        phoneNumber.keyboardType = .NumberPad
        bgScrollView .addSubview(phoneNumber)
        phoneNumber.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(ScreenWidth+margin)
            make.width.equalTo(ScreenWidth-margin*2)
            make.top.equalTo(10)
            make.height.equalTo(40)
        }
        phoneNumber.tag = 30
        phoneNumber.delegate = self
        newAcountPlace = placerholderLabel(frame: CGRectMake(50, 0, 100, 40), string: "手机号码")
        phoneNumber .addSubview(newAcountPlace)
        //验证码
        let maskCode = MJLoginTextField()
        maskCode.borderFillColor = UIColor.whiteColor()
        bgScrollView .addSubview(maskCode)
        maskCode.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(ScreenWidth+margin)
            make.width.equalTo((ScreenWidth-margin*2)/2)
            make.top.equalTo(phoneNumber.snp_bottom).offset(margin)
            make.height.equalTo(40)
        }
        maskCode.tag = 40
        maskCodePlace = placerholderLabel(frame: CGRectZero, string: "手机验证码")
        maskCode .addSubview(maskCodePlace)
        maskCodePlace.snp_makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.bottom.equalTo(0)
        }
        maskCodePlace.adjustsFontSizeToFitWidth = true
        maskCodePlace.textAlignment = .Center
        maskCode.delegate = self
        //发送验证码
        let sendMaskCode = UIButton(type: .Custom)
        bgScrollView .addSubview(sendMaskCode)
        let offset = ScreenWidth+(ScreenWidth-margin*2)/2+20+margin
        let width = (ScreenWidth-margin*2)/2 - 20
        sendMaskCode.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(offset)
            make.width.equalTo(width)
            make.top.equalTo(phoneNumber.snp_bottom).offset(margin)
            make.height.equalTo(40)
        }
        sendMaskCode.setTitle("发送验证码", forState: UIControlState.Normal)
        sendMaskCode.layer.cornerRadius = 5
        sendMaskCode.layer.masksToBounds = true
        sendMaskCode.layer.borderWidth = 3
        sendMaskCode.layer.borderColor = UIColor.whiteColor().CGColor
        sendMaskCode.titleLabel?.adjustsFontSizeToFitWidth = true
        
        //设置密码
        let setPw = MJLoginTextField()
        setPw.borderFillColor = UIColor.whiteColor()
        bgScrollView .addSubview(setPw)
        setPw.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(ScreenWidth+margin)
            make.width.equalTo(ScreenWidth-margin*2)
            make.top.equalTo(sendMaskCode.snp_bottom).offset(margin)
            make.height.equalTo(40)
        }
        setPw.tag = 50
        settingPwPlace = placerholderLabel(frame: CGRectMake(50, 0, 100, 40), string: "设置密码")
        setPw.secureTextEntry = true
        setPw .addSubview(settingPwPlace)
        setPw.delegate = self
        //注册
        let registerBtn = UIButton(type: .Custom)
        bgScrollView .addSubview(registerBtn)
        registerBtn.snp_makeConstraints { (make) in
            make.left.equalTo(0).offset(ScreenWidth+margin)
            make.width.equalTo(ScreenWidth-margin*2)
            make.top.equalTo(setPw.snp_bottom).offset(margin)
            make.height.equalTo(40)
        }
        registerBtn.backgroundColor = kBlueColor
        registerBtn.layer.cornerRadius = 5
        registerBtn.layer.masksToBounds = true
        registerBtn.setTitle("注册", forState: UIControlState.Normal)
        registerBtn.setTitleColor(UIColor.grayColor(), forState: UIControlState.Selected)
        registerBtn.addTarget(self, action: #selector(registerAction), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    //按钮点击
    func btnClick(button:UIButton)  {
        if button.tag != 20 {
            UIView.animateWithDuration(Double(ref.frame.width*0.0005), animations: {
                self.ref.frame = CGRectMake(self.margin, self.topView.frame.height-2, ScreenWidth/3.5, 2)
                self.bgScrollView.contentOffset = CGPoint(x: 0, y: 0)
            })
        }else{
            UIView.animateWithDuration(Double(ref.frame.width*0.0005), animations: {
               self.ref.frame = CGRectMake(self.margin+self.loginBtn.frame.width+self.margin, self.topView.frame.height-2, ScreenWidth/3.5, 2)
                self.bgScrollView.contentOffset = CGPoint(x: ScreenWidth, y: 0)
            })
        }
    }
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //通知方法 text改变时隐藏placeholder
    func TextFieldTextDidChange(fication : NSNotification)  {
        let sendedTextField = fication.object as! UITextField
        let sendedLabel = sendedTextField.subviews[0]
        sendedLabel.hidden = true
        
        switch sendedTextField.tag {
            
        case 10:
            if NSString(string: sendedTextField.text!).length != 11 {
                return
            }else if NSString(string: sendedTextField.text!).length == 11{
                //判断电话是否存在
                if validateUtils.validatePhoneNumber(sendedTextField.text) != true {
                    print("电话号码错误")
                }else{
                    //MARK:登录时判断电话是否已经注册
                    let phoneModel = MJRequestModel()
                    phoneModel.VALIDATION_CODE = 1234
                    phoneModel.phone = sendedTextField.text!
                    userModel.phone = sendedTextField.text!
                    let dic = ["VALIDATION_CODE":phoneModel.VALIDATION_CODE,"phone":phoneModel.phone]
                    MJNetWorkHelper().judgePhoneNumberIsRegister(isreg, phoneModel: dic, success: { (responseDic, success) in
                        print("返回结果",responseDic)
                        }, fail: { (error) in
                            print("返回错误信息",error)
                    })
                }
                
            }
        case 20:
            userModel.pw = sendedTextField.text!
            return
        case 30:
            if NSString(string: sendedTextField.text!).length != 11 {
                return
            }else if NSString(string: sendedTextField.text!).length == 11{
                //判断电话是否存在
                if validateUtils.validatePhoneNumber(sendedTextField.text) != true {
                    print("电话号码错误")
                }else{
                    //MARK:注册时判断电话是否已经注册
                    let phoneModel = MJRequestModel()
                    
                    phoneModel.phone = sendedTextField.text!
                    registerModel.phone = sendedTextField.text!
                    
                    let dic = ["VALIDATION_CODE":phoneModel.VALIDATION_CODE,"phone":phoneModel.phone]
                    MJNetWorkHelper().judgePhoneNumberIsRegister(isreg, phoneModel: dic, success: { (responseDic, success) in
                        print("返回结果",responseDic)
                        }, fail: { (error) in
                            print("返回错误信息",error)
                    })
                }
                
            }
        case 40:
            //MARK:注册时判断手机验证码是否正确
            return
        case 50:
            //MARK:设置密码
            registerModel.pw = sendedTextField.text!
            return
        default:
            break
        }
        
       
    }
    //通知方法 text介绍编辑时如果字符长度为0，则不隐藏
    func TextDidEndEditing(fication:NSNotification)  {
        let sendedTextField = fication.object as! UITextField
        if NSString(string:sendedTextField.text!).length == 0 {
            let sendedLabel = sendedTextField.subviews[0]
            sendedLabel.hidden = false
        }
        
    }
    //移除通知
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidEndEditingNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidChangeNotification, object: nil)
    }
    //MARK:用户登录操作
    func loginAction()  {
        let dic = ["VALIDATION_CODE":userModel.VALIDATION_CODE,
                   "phone":userModel.phone,
                   "pw":userModel.pw,
                   "describe":userModel.describe]
        if loginOrrigsterClosure != nil{
            loginOrrigsterClosure!(pramiters:dic,type:1)
        }
        
    }
    //MARK:用户注册操作
    func registerAction()  {
        let dic = ["VALIDATION_CODE":registerModel.VALIDATION_CODE,
                   "phone":registerModel.phone,
                   "pw":registerModel.pw]
        if loginOrrigsterClosure != nil {
            loginOrrigsterClosure!(pramiters:dic,type:2)
        }
    }
}

class placerholderLabel: UILabel {
     init(frame: CGRect,string:NSString) {
        super.init(frame: frame)
        self.text = string as String
        self.textColor = UIColor.whiteColor()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
