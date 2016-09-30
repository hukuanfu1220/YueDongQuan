//
//  NewQuanZiViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/21.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class NewQuanZiViewController: MainViewController,UITextFieldDelegate {
lazy var  quanZiImage = UIImageView()
    lazy var quanZiBtn = UIButton()
    var quanZiNameField = MJTextFeild()
    var zhuChangName = MJTextFeild()
    var line = UIView()
    var initNewChangDi = UIButton(type: UIButtonType.Custom)
    var clearBtn = UIButton(type: UIButtonType.Custom)
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "←｜新建圈子", style: .Plain, target: self, action: #selector(back))
        self.createView()
    }
    func createView()  {
        self.view .addSubview(quanZiImage)
        self.view .addSubview(quanZiBtn)
        quanZiImage.snp_makeConstraints { (make) in
            make.top.equalTo(ScreenWidth/9)
            make.width.height.equalTo(ScreenWidth/9*2.5)
            make.centerX.equalTo(self.view.snp_centerX)
        }
        quanZiImage.backgroundColor = UIColor.grayColor()
        quanZiBtn.snp_makeConstraints { (make) in
            make.bottom.equalTo(quanZiImage.snp_bottom)
            make.width.equalTo(quanZiImage.snp_width)
            make.height.equalTo(ScreenWidth/9*2.5/3.5)
            make.left.equalTo(quanZiImage.snp_left)
            
        }
        quanZiBtn.backgroundColor = UIColor.blackColor()
        quanZiBtn.alpha = 0.4
        quanZiBtn.setImage(UIImage(named: "ic_bianji-0"), forState: UIControlState.Normal)
        quanZiBtn.setTitle("圈子图片", forState: UIControlState.Normal)
        quanZiBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
        quanZiBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        quanZiBtn.titleLabel?.font = UIFont.systemFontOfSize(kMidScaleOfFont)
        self.view .addSubview(quanZiNameField)
        quanZiNameField.snp_makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(44)
            make.top.equalTo(quanZiImage.snp_bottom).offset(60)
        }
       
        let label1 = UILabel(frame:CGRectMake(0, 0, (ScreenWidth-20)/4, 30) )
        label1.text = "圈子名"
        quanZiNameField.placeholder = "请填写圈子名"
        quanZiNameField.leftView = label1
        quanZiNameField.leftViewMode = .Always
        self.view .addSubview(zhuChangName)
        zhuChangName.snp_makeConstraints { (make) in
           make.top.equalTo(quanZiNameField.snp_bottom)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(44)
        }
        let label2 = UILabel(frame:CGRectMake(0, 0, (ScreenWidth-20)/4, 30) )
        label2.text = "主场"
        zhuChangName.userInteractionEnabled = false
        zhuChangName.placeholder = "选择场地"
        zhuChangName.delegate = self
        zhuChangName.leftView = label2
        zhuChangName.leftViewMode = .Always
       self.view .addSubview(clearBtn)
        let width = ScreenWidth - (ScreenWidth-20)/4 - 40
        clearBtn.snp_makeConstraints { (make) in
            make.left.equalTo((ScreenWidth-20)/4)
            make.width.equalTo(width)
            make.height.equalTo(44)
            make.top.equalTo(zhuChangName.snp_top)
        }
        clearBtn.backgroundColor = UIColor.clearColor()
        clearBtn .addTarget(self, action: #selector(turn), forControlEvents: UIControlEvents.TouchUpInside)
        self.view .addSubview(line)
        line.snp_makeConstraints { (make) in
            make.height.equalTo(0.8)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalTo(quanZiNameField.snp_top)
        }
        line.backgroundColor = UIColor.blueColor()
        self.view .addSubview(initNewChangDi)
        initNewChangDi.snp_makeConstraints { (make) in
            make.left.equalTo(ScreenWidth/8)
            make.right.equalTo(-ScreenWidth/8)
            make.top.equalTo(zhuChangName.snp_bottom).offset(ScreenHeight/8)
            make.height.equalTo(ScreenWidth/8)
        }
        initNewChangDi.backgroundColor = UIColor.blueColor()
        initNewChangDi.layer.cornerRadius = 5
        initNewChangDi.layer.masksToBounds = true
        initNewChangDi.setTitle("创建圈子", forState: UIControlState.Normal)
        initNewChangDi.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        initNewChangDi .addTarget(self, action: nil, forControlEvents: UIControlEvents.TouchUpInside)
    }
    func back(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK textField Delegate
//    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
//        
//    }
    func turn()  {
        let select = SelectChangDiViewController()
        self.push(select)
    }

    override func viewWillAppear(animated: Bool) {
        self.view.endEditing(true)
    }
}
