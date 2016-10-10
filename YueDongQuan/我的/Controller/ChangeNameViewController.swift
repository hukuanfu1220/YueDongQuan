//
//  ChangeNameViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/19.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class ChangeNameViewController: MainViewController {

    
    var reNamefeild = MJTextFeild()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reNamefeild.frame = CGRectMake(10, 0, ScreenWidth-20, 44)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(getUserName), name: UITextFieldTextDidChangeNotification, object: nil)
        
     self.view .addSubview(reNamefeild)
   
        reNamefeild.placeholder = "姚明"
       
    }
    //MARK:更改名字
    func getUserName(fication:NSNotification)  {
        let updatenameModel = MyInfoModel()
        let textFeild = fication.object as! UITextField
        updatenameModel.name = textFeild.text!
        updatenameModel.uid = NSUserDefaults.standardUserDefaults().objectForKey("uid") as! String
        let dic = ["VALIDATION_CODE":updatenameModel.VALIDATION_CODE,
                   "uid":updatenameModel.uid,
                   "name":updatenameModel.name]
        MJNetWorkHelper().updatename(updatename, updatenameModel: dic, success: { (responseDic, success) in
            
            }) { (error) in
                
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   


}
