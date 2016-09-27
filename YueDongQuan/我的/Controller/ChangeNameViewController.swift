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
        
        
     self.view .addSubview(reNamefeild)
   
        reNamefeild.placeholder = "姚明"
       
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
