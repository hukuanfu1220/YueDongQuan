//
//  ConfirmOldPw.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/19.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class ConfirmOldPw: UIView {

    
    typealias clickAlertClosure = (index: Int,password:NSString) -> Void //声明闭包，点击按钮传值
    //把申明的闭包设置成属性
    var clickClosure: clickAlertClosure?
    //为闭包设置调用函数
    func clickIndexClosure(closure:clickAlertClosure?){
        //将函数指针赋值给myClosure闭包
        clickClosure = closure
    }
    let screen_width = UIScreen.mainScreen().bounds.size.width
    let screen_height = UIScreen.mainScreen().bounds.size.height
    let whiteView = UIView() //白色框
    let titleLabel = UILabel() //标题按钮
    let contentLabel = UILabel() //显示内容
    var title = "" //标题
    var content = "" //内容
    var passWord = MJTextFeild()
    let cancelBtn = UIButton() //取消按钮
    let sureBtn = UIButton() //确定按钮
    let tap = UITapGestureRecognizer() //点击手势
    
    //旧密码
    var oldString : NSString!
    
    
    
    init(title: String?, message: String?, cancelButtonTitle: String?, sureButtonTitle: String?) {
        super.init(frame: CGRect(x: 0, y: 0, width: screen_width, height: screen_height))
        createAlertView()
        self.titleLabel.text = title
        self.contentLabel.text = message
        self.cancelBtn.setTitle(cancelButtonTitle, forState: .Normal)
        self.sureBtn.setTitle(sureButtonTitle, forState: .Normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:创建
    func createAlertView() {
        //布局
        self.frame = CGRect(x: 0, y: 0, width: screen_width, height: screen_height)
        self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.2)
        tap.addTarget(self, action: #selector(ConfirmOldPw.dismiss))
        self.addGestureRecognizer(tap)
        //白底
        whiteView.frame = CGRect(x: 30, y: screen_height/2 - 100, width: screen_width - 60, height: 200)
        whiteView.backgroundColor = UIColor.whiteColor()
        whiteView.layer.cornerRadius = 5
        whiteView.clipsToBounds = true
        self.addSubview(whiteView)
        let width = whiteView.frame.size.width
        //标题
        titleLabel.frame = CGRect(x: 0, y: 15, width: width, height: 25)
        titleLabel.textColor = RGB_Color(r: 66, g: 66, b: 66, a: 1)
        titleLabel.font = UIFont.systemFontOfSize(kTopScaleOfFont)
        titleLabel.textAlignment = .Center
        whiteView.addSubview(titleLabel)
        //内容
        contentLabel.frame = CGRect(x: 24, y: 45, width: width - 48, height: 20)
        contentLabel.numberOfLines = 0
        contentLabel.textAlignment = .Center
        contentLabel.textColor = RGB_Color(r: 66, g: 66, b: 66, a: 1)
        contentLabel.font = UIFont.systemFontOfSize(kTopScaleOfFont)
        whiteView.addSubview(contentLabel)
        passWord.frame = CGRectMake(24, 90, width-48, 30)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(passwordMask), name: UITextFieldTextDidChangeNotification, object: nil)
        whiteView .addSubview(passWord)
        //取消按钮
        let btnWith = (width - 130) / 2/2
        cancelBtn.frame = CGRect(x: width-btnWith*2, y: 165, width: btnWith, height: 20)
        cancelBtn.backgroundColor = UIColor.whiteColor()
        cancelBtn.setTitleColor(RGB_Color(r: 150, g: 150, b: 150, a: 1), forState: UIControlState.Normal)
        cancelBtn.titleLabel?.font = UIFont.systemFontOfSize(kTopScaleOfFont)
        cancelBtn.layer.cornerRadius = 3
        cancelBtn.clipsToBounds = true
        cancelBtn.tag = 1
        cancelBtn.addTarget(self, action: #selector(clickBtnAction), forControlEvents: .TouchUpInside)
        whiteView.addSubview(cancelBtn)
        //确认按钮
        sureBtn.frame = CGRect(x: width-btnWith , y: 165, width: btnWith, height: 20)
        sureBtn.backgroundColor = UIColor.whiteColor()
        sureBtn.setTitleColor(kBlueColor, forState: UIControlState.Normal)
        sureBtn.titleLabel?.font = UIFont.systemFontOfSize(kTopScaleOfFont)
        sureBtn.layer.cornerRadius = 3
        sureBtn.clipsToBounds = true
        sureBtn.tag = 2
        sureBtn.addTarget(self, action: #selector(clickBtnAction), forControlEvents: .TouchUpInside)
        whiteView.addSubview(sureBtn)
    }
    //MARK:按键的对应的方法 输入密码结束时的通知方法
    func clickBtnAction(sender: UIButton) {
        self.endEditing(true)
        
        if (clickClosure != nil) {
         
            clickClosure!(index: sender.tag,password:oldString)
        }
        dismiss()
    }
    //MARK:消失
    func dismiss() {
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.whiteView.alpha = 0
            self.alpha = 0
        }) { (finish) -> Void in
            if finish {
                self.removeFromSuperview()
            }
        }
    }
    /** 指定视图实现方法 */
    func show() {
        let wind = UIApplication.sharedApplication().keyWindow
        self.alpha = 0
        wind?.addSubview(self)
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.alpha = 1
        })
    }
    //MARK: 转换颜色
    func RGB_Color(r r: CGFloat, g:CGFloat, b:CGFloat, a: CGFloat) -> UIColor {
        return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
    func passwordMask(fication:NSNotification)  {
        let textFeild = fication.object as! UITextField
        oldString = textFeild.text!
    }

}
