//
//  OtherQuanZiViewController.swift
//  YueDongQuan
//
//  Created by 黄方果 on 16/9/26.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class OtherQuanZiViewController: MainViewController {
    var  otherView : MJOtherQuanZiView!
    override func viewDidLoad() {
        super.viewDidLoad()

       otherView  = MJOtherQuanZiView(frame: self.view.frame)
        self.view .addSubview(otherView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        
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
