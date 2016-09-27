//
//  PostVideoController.swift
//  YueDongQuan
//
//  Created by HKF on 16/9/26.
//  Copyright © 2016年 黄方果. All rights reserved.
//

import UIKit

class PostVideoController: UIViewController,CustomTextFieldDelegate {
    
    var sayTextField = CustomTextField(frame: CGRect(x: 10, y: 10, width: ScreenWidth - 20, height: 30), placehoder: "说点什么吧....(120字内)", fontSize: UIFont.systemFontOfSize(14))

    override func viewDidLoad() {
        super.viewDidLoad()

        self.edgesForExtendedLayout = .None
//        setNav()
        
        sayTextField.textDelegate = self
        self.view.addSubview(sayTextField)
    
    }
    
    override func viewWillAppear(animated: Bool) {
        setNav()
    }
    
    func setNav(){
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        let imgView = UIImageView(frame:leftView.frame)
        imgView.image = UIImage(named: "CDEditBack.jpg")
        imgView.contentMode = .Center
        leftView.addSubview(imgView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissVC))
        
        leftView.addGestureRecognizer(tap)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftView)
        self.navigationController?.navigationBar.barTintColor = UIColor ( red: 0.451, green: 0.6824, blue: 0.3098, alpha: 1.0 )
        self.navigationController?.navigationBar.tintColor = UIColor.blackColor()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(),forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = nil
    }
    func dismissVC(){
        self.dismissViewControllerAnimated(true) {
            
        }
    }
    
    
    
    func getTextString(text: String) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
